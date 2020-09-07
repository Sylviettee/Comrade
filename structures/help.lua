local get
get = require('../init').get
local command = require('./command')
local embed = require('./embed')
local help
do
  local _class_0
  local _parent_0 = command
  local _base_0 = {
    all = function(msg, _, client)
      local helpEmbed = embed():setTitle('Help')
      local desc = ''
      client.commands:forEach(function(command)
        desc = tostring(desc) .. ", `" .. tostring(command.name) .. "`"
      end)
      desc = desc:sub(2, #desc)
      helpEmbed:setDescription(desc)
      return helpEmbed:send(msg.channel)
    end,
    execute = function(self, msg, args, client)
      if not (args[1]) then
        return self['all'](msg, args, client)
      else
        command = client.commands:find(function(com)
          return com.name == args[1] or table.search(com.aliases, args[1])
        end)
        if command then
          return command:help(msg.channel)
        else
          return msg:reply('Could\'t find that command')
        end
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      _class_0.__parent.__init(self)
      self.usage = '[all | command name]'
      self.example = tostring(self.name) .. " all"
      self.description = 'The help command to give you all the commands'
    end,
    __base = _base_0,
    __name = "help",
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
  help = _class_0
  return _class_0
end
