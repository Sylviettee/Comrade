----
-- A embed helper class
-- @classmod emitter
import setTimeout, clearTimeout from require 'timer'

import wrap, yield, running, resume from coroutine
import insert, remove from table

new = (name, listener) =>
  listeners = @listeners[name]

  unless listeners
    listeners = {}
    @listeners[name] = listeners

  insert listeners, listener

  listener.fn

class
  @__name = 'Emitter'
  --- Create a new emitter
  new: () =>
    @listeners = {}

  --- Listen to the emitter
  -- @tparam string name The name of the event
  -- @tparam function fn The callback function
  on: (name, fn) =>
    new @, name, {fn: fn}

  --- Listen to the emitter once
  -- @tparam string name The name of the event
  -- @tparam function fn The callback function
  once: (name, fn) =>
    new @, name, {fn: fn, once: true}

  --- Emit an event
  -- @tparam string name The name of the event
  -- @tparam ?{any,...} data The data to emit
  emit: (name, ...) =>
    listeners = @listeners[name]

    return unless listeners 

    for i = 1, #listeners
      listener = listeners[i]
      if listener
        fn = listener.fn
        if listener.once
          listeners[i] = false

        wrap(fn) ...

    if listeners.removed
      for i = #listeners, 1, -1
        unless listeners[i]
          remove listeners, i

      if #listeners == 0
        @listeners[name] = nil

      listeners.removed = nil
  
  --- Remove a listener from an event
  -- @tparam string name The name of the event
  -- @tparam function fn The callback function
  removeListener: (name, fn) =>
    listeners = @listeners[name]
    return unless listeners

    for i, listener in ipairs listeners
      if listener and listener.fn == fn
        listeners[i] = false

    listeners.removed = true
  
  --- Wait for an event to be fired in a certain timeframe matching an optional predicate
  -- @tparam string name The name of the event
  -- @tparam ?number timeout The amount of time to wait before timing out
  -- @tparam ?function predicate The function that has to return true in order to return a value
  waitFor: (name, timeout, predicate) =>
    local fn
    thread = running!

    fn = @on name, (...) ->
      if predicate and not predicate(...) 
        return
      if timeout then
        clearTimeout timeout

      @removeListener name, fn

      return assert resume thread, true, ...

    timeout = timeout and setTimeout timeout, () ->
      @removeListener name, fn

      return assert resume thread, false

    return yield!