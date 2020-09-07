local get, version, name
do
  local _obj_0 = require('../init')
  get, version, name = _obj_0.get, _obj_0.version, _obj_0.name
end
local internalError = require('./internalError')
local array = require('./array')
local discordia = require('discordia')
local enums
enums = discordia.enums
local Class, Client = discordia.class, discordia.Client
local helper
helper, get = Class('Helper Client', Client)
local options = {
  'routeDelay',
  'maxRetries',
  'shardCount',
  'firstShard',
  'lastShard',
  'largeThreshold',
  'cacheAllMembers',
  'autoReconnect',
  'compress',
  'bitrate',
  'logFile',
  'logLevel',
  'gatewayFile',
  'dateTime',
  'syncGuilds'
}
helper.__init = function(self, token, config)
  if config == nil then
    config = { }
  end
  local clientConfig = { }
  for i, v in pairs(config) do
    if table.search(options, i) then
      clientConfig[i] = v
    end
  end
  Client.__init(self, clientConfig)
  assert(token, 'A token is required!')
  self._token = token
  self._prefix = config.prefix or '!'
  self._defaultHelp = config.defaultHelp or true
  self._owners = config.owners or { }
  self._start = os.time()
  self._commands = array()
  self._events = array()
  self._plugins = array()
  self._events = array()
  _G.intAssert = function(condition, message)
    if message == nil then
      message = 'Condition is false'
    end
    if not (condition) then
      return internalError(message, self):send()
    end
  end
  _G.intError = function(message)
    return internalError(message, self):send()
  end
  self:on('ready', function()
    self:info("Ready as " .. tostring(self.user.tag))
    if self._defaultHelp then
      return self:addCommand(require('./help'))
    end
  end)
  return self:on('messageCreate', function(msg)
    if not (string.startswith(msg.content, self._prefix)) then
      return 
    end
    local perms = msg.guild.me:getPermissions(msg.channel)
    if not (perms:has(enums.permission.sendMessages)) then
      return self:debug("Comrade : No send messages")
    end
    local command = string.split(msg.content, ' ')
    command = string.gsub(command[1], self._prefix, '')
    local args = table.slice(string.split(msg.content, ' '), 2)
    command = command:lower()
    local found = self._commands:find(function(val)
      return val:check(command, msg, self)
    end)
    if found then
      self:debug("Comrade : Ran " .. tostring(command))
      local succ, err = pcall(function()
        return found:run(msg, args, self)
      end)
      if not (succ) then
        self:debug("Comrade : Error " .. tostring(err))
        return intError(err)
      end
    end
  end)
end
helper.login = function(self, status)
  self:run("Bot " .. tostring(self._token))
  if status then
    return self:setGame(status)
  end
end
helper.addCommand = function(self, command)
  self:debug("Comrade: New command " .. tostring(command.name))
  return self._commands:push(command)
end
helper.removeCommand = function(self, name, check)
  if check == nil then
    check = function()
      return true
    end
  end
  return self._commands:forEach(function(command, pos)
    if command.name == name and check(event) then
      return self._commands:pop(pos)
    end
  end)
end
helper.addEvent = function(self, event)
  self:debug("Comrade: New listener " .. tostring(event.name))
  event:use(self)
  return self._events:push(event)
end
helper.removeEvent = function(self, name, check)
  if check == nil then
    check = function()
      return true
    end
  end
  return self._events:forEach(function(event, pos)
    if event.name == name and check(event) then
      self._events:pop(pos)
      return self:removeListener(event.__class.__name, event.execute)
    end
  end)
end
helper.removePlugin = function(self, name) end
get.start = function(self)
  return self._start
end
get.commands = function(self)
  return self._commands
end
get.version = function()
  return version
end
get.owners = function(self)
  return self._owners
end
return helper
