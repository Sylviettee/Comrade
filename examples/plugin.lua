local plugin
plugin = require('comrade').plugin
local pluginname
do
  local _class_0
  local _parent_0 = plugin
  local _base_0 = { }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      _class_0.__parent.__init(self)
      local commandname
      do
        local _class_1
        local _parent_1 = self.command
        local _base_1 = {
          subcommand = function(self, msg, args, client)
            return msg:reply('Subcommand!')
          end,
          execute = function(self, msg, args, client)
            return self:help(msg.channel)
          end
        }
        _base_1.__index = _base_1
        setmetatable(_base_1, _parent_1.__base)
        _class_1 = setmetatable({
          __init = function(self)
            _class_1.__parent.__init(self)
            self.name = ''
            self.aliases = {
              ''
            }
            self.permissions = {
              ''
            }
            self.hidden = false
            self.allowDMS = false
            self.cooldown = 3000
            self.description = ''
            self.usage = ''
            self.example = ''
          end,
          __base = _base_1,
          __name = "commandname",
          __parent = _parent_1
        }, {
          __index = function(cls, name)
            local val = rawget(_base_1, name)
            if val == nil then
              local parent = rawget(cls, "__parent")
              if parent then
                return parent[name]
              end
            else
              return val
            end
          end,
          __call = function(cls, ...)
            local _self_0 = setmetatable({}, _base_1)
            cls.__init(_self_0, ...)
            return _self_0
          end
        })
        _base_1.__class = _class_1
        if _parent_1.__inherited then
          _parent_1.__inherited(_parent_1, _class_1)
        end
        commandname = _class_1
      end
      local messageCreate
      do
        local _class_1
        local _parent_1 = self.event
        local _base_1 = {
          execute = function(self, msg)
            return p(msg)
          end
        }
        _base_1.__index = _base_1
        setmetatable(_base_1, _parent_1.__base)
        _class_1 = setmetatable({
          __init = function(self, ...)
            return _class_1.__parent.__init(self, ...)
          end,
          __base = _base_1,
          __name = "messageCreate",
          __parent = _parent_1
        }, {
          __index = function(cls, name)
            local val = rawget(_base_1, name)
            if val == nil then
              local parent = rawget(cls, "__parent")
              if parent then
                return parent[name]
              end
            else
              return val
            end
          end,
          __call = function(cls, ...)
            local _self_0 = setmetatable({}, _base_1)
            cls.__init(_self_0, ...)
            return _self_0
          end
        })
        _base_1.__class = _class_1
        if _parent_1.__inherited then
          _parent_1.__inherited(_parent_1, _class_1)
        end
        messageCreate = _class_1
        return _class_1
      end
    end,
    __base = _base_0,
    __name = "pluginname",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
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
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  pluginname = _class_0
end
return pluginname()
