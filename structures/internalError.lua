local Error
do
  local _class_0
  local _base_0 = {
    send = function(self)
      if not (self.client) then
        print("Unhandled Error; \n" .. tostring(self.message) .. "\n" .. tostring(self.traceback))
        return process:exit()
      else
        self.client:debug(self.message)
        if self.client:getListenerCount('error') > 0 then
          return self.client:error(self.message)
        else
          print("Unhandled Error; " .. tostring(self.message) .. "\n" .. tostring(self.traceback))
          return process:exit()
        end
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, message, client)
      self.message = message
      self.traceback = debug.traceback()
      self.client = client
    end,
    __base = _base_0,
    __name = "Error"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Error = _class_0
  return _class_0
end
