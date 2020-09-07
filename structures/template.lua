local lustache = require('../libs/')
local Embed = require('./Embed')
local deepScan
deepScan = function(tbl, fn)
  for _, v in pairs(tbl) do
    if type(v) == 'table' then
      deepScan(v, fn)
    else
      fn(v)
    end
  end
end
local Template
do
  local _class_0
  local _parent_0 = Embed
  local _base_0 = {
    render = function(self, env)
      return deepScan(self:toJSON(), function(val)
        if type(val) == 'string' then
          return lustache:render(val, env)
        end
      end)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, start)
      return _class_0.__parent.__init(self, start)
    end,
    __base = _base_0,
    __name = "Template",
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
  Template = _class_0
  return _class_0
end
