local Command
do
  local _obj_0 = require('comrade')
  Command = _obj_0.Command
end
local commandname
do
  local _class_0
  local _parent_0 = Command
  local _base_0 = {
    subcommand = function(self, msg, args, client) return msg:reply('Subcommand!') end,
    execute = function(self, msg, args, client) return self:help(msg.channel) end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      _class_0.__parent.__init(self)
      self.name = ''
      self.aliases = {''}
      self.permissions = {''}
      self.hidden = false
      self.allowDMS = false
      self.cooldown = 3000
      self.description = ''
      self.usage = ''
      self.example = ''
    end,
    __base = _base_0,
    __name = 'commandname',
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
  if _parent_0.__inherited then _parent_0.__inherited(_parent_0, _class_0) end
  commandname = _class_0
end
return commandname()
