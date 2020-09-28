local setTimeout, clearTimeout
do
  local _obj_0 = require('timer')
  setTimeout, clearTimeout = _obj_0.setTimeout, _obj_0.clearTimeout
end
local wrap, yield, running, resume
do
  local _obj_0 = coroutine
  wrap, yield, running, resume = _obj_0.wrap, _obj_0.yield, _obj_0.running, _obj_0.resume
end
local insert, remove
do
  local _obj_0 = table
  insert, remove = _obj_0.insert, _obj_0.remove
end
local new
new = function(self, name, listener)
  local listeners = self.listeners[name]
  if not (listeners) then
    listeners = {}
    self.listeners[name] = listeners
  end
  insert(listeners, listener)
  return listener.fn
end
do
  local _class_0
  local _base_0 = {
    on = function(self, name, fn) return new(self, name, {fn = fn}) end,
    once = function(self, name, fn) return new(self, name, {fn = fn, once = true}) end,
    emit = function(self, name, ...)
      local listeners = self.listeners[name]
      if not (listeners) then return end
      for i = 1, #listeners do
        local listener = listeners[i]
        if listener then
          local fn = listener.fn
          if listener.once then listeners[i] = false end
          wrap(fn)(...)
        end
      end
      if listeners.removed then
        for i = #listeners, 1, -1 do if not (listeners[i]) then remove(listeners, i) end end
        if #listeners == 0 then self.listeners[name] = nil end
        listeners.removed = nil
      end
    end,
    removeListener = function(self, name, fn)
      local listeners = self.listeners[name]
      if not (listeners) then return end
      for i, listener in ipairs(listeners) do if listener and listener.fn == fn then listeners[i] = false end end
      listeners.removed = true
    end,
    waitFor = function(self, name, timeout, predicate)
      local fn
      local thread = running()
      fn = self:on(name, function(...)
        if predicate and not predicate(...) then return end
        if timeout then clearTimeout(timeout) end
        self:removeListener(name, fn)
        return assert(resume(thread, true, ...))
      end)
      timeout = timeout and setTimeout(timeout, function()
        self:removeListener(name, fn)
        return assert(resume(thread, false))
      end)
      return yield()
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({__init = function(self) self.listeners = {} end, __base = _base_0, __name = nil}, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self.__name = 'Emitter'
  return _class_0
end
