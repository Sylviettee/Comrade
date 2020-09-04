----
-- A plugin that functions like a dpy cog, should be extended
-- @classmod plugin

command = require './command'
event = require './event'

class plguinCommand extends command
  @commands = {}
  @__inherited: (klass) =>
    table.insert @@commands, klass!
  @clear: () =>
    @@commands = {}

class pluginEvent extends event
  @events = {}
  @__inherited: (klass) =>
    table.insert @@events, klass!
  @clear: () =>
    @@events = {}

class plugin
  --- Create a new plugin, sets 2 properties, @command and @event. These should be used inplace of command and event
  new: () =>
    @command = plguinCommand
    @event = pluginEvent
  --- Allows the plugin to be used by the client
  -- @tparam client client The client to use the plugin on
  use: (client) =>
    --for _,v in pairs @events
      --client\on v.event, v.listener
    for _,v in pairs plguinCommand.commands
      v.parent = @@__name
      client\addCommand v

    for _,v in pairs pluginEvent.events
      v.parent = @@__name
      client\addEvent v

    plguinCommand\clear!
    pluginEvent\clear!