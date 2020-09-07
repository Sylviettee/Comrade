local array
do
  local _class_0
  local _base_0 = {
    __len = function(self)
      return #self.data
    end,
    __pairs = function(self)
      local func
      func = function(tbl, k)
        local v
        k, v = next(tbl, k)
        if v then
          return k, v
        end
      end
      return func, self.data, nil
    end,
    forEach = function(self, func)
      for i, v in pairs(self.data) do
        func(v, i, self.data)
      end
    end,
    filter = function(self, func)
      local data = { }
      for _, v in pairs(self.data) do
        if func(v) then
          table.insert(data, v)
        end
      end
      return array(unpack(data))
    end,
    find = function(self, func)
      for i, v in pairs(self.data) do
        if func(v) then
          return v, i
        end
      end
    end,
    map = function(self, func)
      local newData = { }
      for _, v in pairs(self) do
        table.insert(newData, func(v))
      end
      return array(unpack(newData))
    end,
    push = function(self, item)
      return table.insert(self.data, item)
    end,
    slice = function(self, start, stop, step)
      return table.slice(self.data, start, stop, step)
    end,
    shift = function(self)
      return table.remove(self.data, 1)
    end,
    pop = function(self, pos)
      return table.remove(self.data, pos)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, ...)
      self.data = {
        ...
      }
    end,
    __base = _base_0,
    __name = "array"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  array = _class_0
  return _class_0
end
