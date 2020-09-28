local logger = require('./logger')
local It
do
  local _class_0
  local _base_0 = {
    run = function(self, env)
      if env == nil then env = {} end
      local funcEnv = getfenv(self.fn)
      for i, v in pairs(env) do funcEnv[i] = v end
      local succ, err = pcall(self.fn)
      return logger.test(self.name, not succ and err)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, parent, name, fn)
      self.parent = parent
      self.name = name
      self.fn = fn
    end,
    __base = _base_0,
    __name = 'It'
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  It = _class_0
end
local Describe
do
  local _class_0
  local _base_0 = {
    run = function(self, env)
      if env == nil then env = {} end
      if not (self.canLoad) then return end
      for _, v in pairs(self.cases) do
        table.insert(self.out, v:run(env))
        collectgarbage('collect')
      end
      return print(table.concat(self.out, '\n'))
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, test, fn)
      self.name = test
      self.cases = {}
      self.out = {}
      self.canLoad = true
      local env = getfenv(fn)
      env.it = function(name, fn) return table.insert(self.cases, It(self, name, fn)) end
      env.depend = function(name) return require(name) end
      local succ, err = pcall(fn)
      self.canLoad = succ
      table.insert(self.out, logger.case(test))
      if not (self.canLoad) then return table.insert(self.out, logger.test('Load tests', err)) end
    end,
    __base = _base_0,
    __name = 'Describe'
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Describe = _class_0
end
return Describe
