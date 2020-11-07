do
  local _class_0
  local _base_0 = {
    __len = function(self) return #self.data end,
    peek = function(self) return self.data[#self.data] end,
    push = function(self, ...) for _, v in pairs({...}) do table.insert(self.data, v) end end,
    pop = function(self) return table.remove(self.data) end,
    forEach = function(self, fn) for _ = 1, #self.data do fn(self:pop()) end end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, initialState)
      if initialState == nil then initialState = {} end
      self.data = initialState
    end,
    __base = _base_0
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0;
  self.__name = 'Stack'
  return _class_0
end
