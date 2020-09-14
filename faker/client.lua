local readdirSync, readFileSync
do
  local _obj_0 = require('fs')
  readdirSync, readFileSync = _obj_0.readdirSync, _obj_0.readFileSync
end
local sleep
sleep = require('timer').sleep
local Client = require('../structures/client')
local Array = require('../structures/array')
local Stack = require('./stack')
local Describe = require('./framework')
local logger = require('./logger')
local discordia = require('discordia')
local _class = discordia.class
local faker, get = _class('Faker Helper', Client)
faker.__init = function(self, token, config)
  if config == nil then config = {} end
  Client.__init(self, token, config)
  self._defaultChannel = config.channel
  self._mainbot = config.mainbot
  self._waitTime = config.waitTime or 10000
  self._sleepTime = config.sleepTime or 2500
  self._testStack = Stack()
  return self:on('ready', function()
    if self._defaultChannel then self._defaultChannel = self:getChannel(self._defaultChannel) end
  end)
end
faker.deauth = function(self)
  local current = self._mainbot.owners
  local new = {}
  for _, v in pairs(current) do if v ~= self.user.id then table.insert(new, v) end end
  return self._mainbot:updateOwners(new)
end
faker.auth = function(self)
  local current = table.clone(self._mainbot.owners)
  table.insert(current, self.user.id)
  return self._mainbot:updateOwners(current)
end
faker.send = function(self, msg, channel)
  local toSend = assert(((channel and self:getChannel(channel)) or self._defaultChannel), 'No channel found')
  return toSend:send(msg)
end
faker.case = function(self, test, fn) return self._testStack:push({test = test, fn = fn}) end
faker.execute = function(self, content, channel)
  self:send(content, channel)
  local didReply, reply = self:waitFor('messageCreate', self._waitTime,
                                       function(msg) return msg.author.id == self._mainbot.user.id end)
  return didReply and reply or nil
end
faker.load = function(self, dir)
  local tests = Array(unpack(readdirSync(dir))):filter(function(file) return file:match('.+%.spec%.lua$') end)
  return tests:forEach(function(file)
    local test = readFileSync(tostring(dir) .. '/' .. tostring(file))
    local sandbox = setmetatable({}, {__index = _G})
    sandbox.describe = function(...) return self._testStack:push(Describe(...)) end
    local fn, syntax = load(test, 'Test', 't', sandbox)
    if not (fn) then return logger.test(file, syntax) end
    local succ, err = pcall(fn)
    if not (succ) then return logger.test(file, err) end
  end)
end
faker.executeTests = function(self)
  local current = coroutine.running()
  local co = coroutine.create(function()
    self._testStack:forEach(function(test)
      pcall(test.run, test, {bot = self._mainbot, tester = self, execute = function(...) return self:execute(...) end})
      self._mainbot:resetErrors()
      self:resetErrors()
      return sleep(self._sleepTime, coroutine.running())
    end)
    return coroutine.resume(current)
  end)
  coroutine.resume(co)
  coroutine.yield()
  return logger.finish()
end
get.errored = function(self) return #self._mainbot.errors > 0 or #self._errors > 0 end
get.channel = function(self) return self._defaultChannel end
return faker
