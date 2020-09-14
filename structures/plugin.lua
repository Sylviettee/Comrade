local command = require('./command')
local event = require('./event')
local plguinCommand
do
  local _class_0
  local _parent_0 = command
  local _base_0 = {}
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...) return _class_0.__parent.__init(self, ...) end,
    __base = _base_0,
    __name = 'plguinCommand',
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, '__parent')
        if parent then return parent[name] end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self.commands = {}
  self.__inherited = function(self, klass) return table.insert(self.__class.commands, klass()) end
  self.clear = function(self) self.__class.commands = {} end
  if _parent_0.__inherited then _parent_0.__inherited(_parent_0, _class_0) end
  plguinCommand = _class_0
end
local pluginEvent
do
  local _class_0
  local _parent_0 = event
  local _base_0 = {}
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...) return _class_0.__parent.__init(self, ...) end,
    __base = _base_0,
    __name = 'pluginEvent',
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, '__parent')
        if parent then return parent[name] end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self.events = {}
  self.__inherited = function(self, klass) return table.insert(self.__class.events, klass()) end
  self.clear = function(self) self.__class.events = {} end
  if _parent_0.__inherited then _parent_0.__inherited(_parent_0, _class_0) end
  pluginEvent = _class_0
end
do
  local _class_0
  local _base_0 = {
    use = function(self, client)
      for _, v in pairs(plguinCommand.commands) do
        v.parent = self.__class.__name
        client:addCommand(v)
      end
      for _, v in pairs(pluginEvent.events) do
        v.parent = self.__class.__name
        client:addEvent(v)
      end
      plguinCommand:clear()
      return pluginEvent:clear()
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.command = plguinCommand
      self.event = pluginEvent
    end,
    __base = _base_0,
    __name = nil
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self.__name = 'Plugin'
  return _class_0
end
