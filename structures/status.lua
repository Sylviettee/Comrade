local request
do
  local _obj_0 = require('coro-http')
  request = _obj_0.request
end
local parse
do
  local _obj_0 = require('json')
  parse = _obj_0.parse
end
local command = require('./command')
local tabular = require('../libs/tabular')
local haste = 'https://hasteb.in/'
local status
do
  local _class_0
  local _parent_0 = command
  local _base_0 = {
    execute = function(self, msg, _, client)
      local commands = {}
      client.commands:forEach(function(command)
        commands[command.name] = {errors = command.errors, tested = command.tested}
      end)
      local content = tabular({
        ['Cache'] = {['Guilds'] = #client.guilds, ['Users'] = #client.users, ['Dms'] = #client.privateChannels},
        ['Commands'] = commands,
        ['Memory Usage'] = tostring(math.round((process.memoryUsage().heapUsed / 1024 / 1024) * 100) / 100) .. ' MB'
      })
      if #content < 1990 then
        return msg:reply('```\n' .. tostring(content) .. '```')
      else
        local res
        _, res = request('POST', tostring(haste) .. 'documents',
                         {{'Content-Type', 'text/plain'}, {'Content-Length', #content}}, content)
        local body = parse(res)
        local key = body.key
        return msg:reply('Content too large;\nPlease see: ' .. tostring(haste) .. tostring(key) .. '.txt')
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      _class_0.__parent.__init(self)
      self.usage = tostring(self.name)
      self.example = tostring(self.name)
      self.description = 'Shows status of tests'
      self.hidden = true
    end,
    __base = _base_0,
    __name = 'status',
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
  status = _class_0
end
return status()
