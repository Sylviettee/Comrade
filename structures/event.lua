local event
do
  local _class_0
  local _base_0 = {
    use = function(self, client)
      if not (self.once) then
        return client:on(self.name, self.execute)
      else
        return client:once(self.name, self.execute)
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      intAssert(self.execute, 'No execution for event was found')
      self.name = self.__class.__name
    end,
    __base = _base_0,
    __name = "event"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  event = _class_0
  return _class_0
end
