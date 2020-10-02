local Command, ArgParse
do
  local _obj_0 = require('../init')
  Command, ArgParse = _obj_0.Command, _obj_0.ArgParse
end
local test
do
  local _class_0
  local _parent_0 = Command
  local _base_0 = {
    execute = function(self, msg, args)
      local sum = args.numOne + args.numTwo
      return msg:reply('The sum is ' .. tostring(sum) .. ' and the member is ' .. tostring(args.member.user.tag) .. '!')
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      _class_0.__parent.__init(self)
      return self:addMiddleware(ArgParse({
        {id = 'numOne', type = 'int'}, {id = 'numTwo', type = 'int', default = 0},
        {id = 'member', type = 'member', default = function(msg) return msg.member end}
      }, self))
    end,
    __base = _base_0,
    __name = 'test',
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
  test = _class_0
  return _class_0
end
