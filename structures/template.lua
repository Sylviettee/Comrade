local lustache = require('../libs/lustache')
local etlua = require('../libs/etlua')
local Embed = require('./embed')
local deepScan
deepScan = function(tbl, fn)
  local clone = table.clone(tbl)
  for i, v in pairs(clone) do
    if type(v) == 'table' then
      clone[i] = deepScan(v, fn)
    else
      clone[i] = fn(v)
    end
  end
  return clone
end
local Template
do
  local _class_0
  local _parent_0 = Embed
  local _base_0 = {
    render = function(self, env)
      if env == nil then
        env = { }
      end
      local tbl = deepScan(self:toJSON(), function(val)
        if type(val) == 'string' then
          return self:renderer(val, env)
        end
      end)
      return Embed(tbl)
    end,
    construct = function(self, env, useEtLua)
      if env == nil then
        env = { }
      end
      if useEtLua == nil then
        useEtLua = false
      end
      local tbl = deepScan(self:toJSON(), function(val)
        if type(val) == 'string' then
          return self:renderer(val, env)
        end
      end)
      return Template(tbl, useEtLua)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, start, useEtLua)
      if start == nil then
        start = { }
      end
      if useEtLua == nil then
        useEtLua = false
      end
      _class_0.__parent.__init(self, start)
      self.usingEtLua = useEtLua
      if self.usingEtLua then
        self.renderer = function(self, ...)
          return etlua.render(...)
        end
      else
        self.renderer = function(self, ...)
          return lustache:render(...)
        end
      end
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
