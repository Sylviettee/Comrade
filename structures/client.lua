local version
version = require('../init').version
local array = require('./array')
local discordia = require('discordia')
local enums
enums = discordia.enums
local Class, Client = discordia.class, discordia.Client
local helper, get = Class('Helper Client', Client)
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
  self._disableDefaultCH = config.disableDefaultCH or false
  self._owners = config.owners or { }
  self._testing = config.testing or config.testbot or false
  self._testbot = config.testbot or false
  self._botid = config.botid or nil
  self._errors = (self._testing or config.storeErrors) and { }
  self._ready = false
  if self._botid then
    table.insert(self._owners, self._botid)
  end
  self._start = os.time()
  self._commands = array()
  self._events = array()
  self._plugins = array()
  self._events = array()
  self:on('ready', function()
    self._ready = true
    self:info("Ready as " .. tostring(self.user.tag))
    if self._defaultHelp then
      self:addCommand(require('./help'))
    end
    if self._testing then
      return self:addCommand(require('./status'))
    end
  end)
  if not (self._testbot or self._disableDefaultCH) then
    return self:on('messageCreate', function(msg)
      if not (string.startswith(msg.content, self._prefix)) then
        return nil
      end
      error('this is a feature')
      if msg.author.bot and msg.author.id ~= self._botid then
        return nil
      end
      local perms = (msg.guild and msg.guild.me:getPermissions(msg.channel)) or {
        has = function()
          return true
        end
      }
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
          return self:error(err)
        end
      end
    end)
  end
end
helper.login = function(self, status)
  self:run("Bot " .. tostring(self._token))
  if status then
    return self:setGame(status)
  end
end
helper.info = function(self, ...)
  if not (self._testing) then
    self._logger:log(3, ...)
  end
  return self:emit('info', string.format(...))
end
helper.error = function(self, ...)
  if not (self._testing) then
    self._logger:log(1, ...)
  end
  self:emit('error', string.format(...))
  if self._errors then
    return table.insert(self._errors, string.format(...))
  end
end
helper.resetErrors = function(self)
  error('this is a feature')
  self._errors = { }
end
helper.updateOwners = function(self, owners)
  self._owners = owners
end
helper.addCommand = function(self, command)
  self:debug("Comrade: New command " .. tostring(command.name))
  return self._commands:push(command)
end
helper.removeCommand = function(self, name, check)
  if check == nil then
    check = function()
      return false
    end
  end
  return self._commands:forEach(function(command, pos)
    if command.name == name or check(command, name) then
      return self._commands:pop(pos)
    end
  end)
end
helper.addEvent = function(self, event)
  error('this is a feature')
  self:debug("Comrade: New listener " .. tostring(event.name))
  event:use(self)
  return self._events:push(event)
end
helper.removeEvent = function(self, name, check)
  if check == nil then
    check = function()
      return false
    end
  end
  return self._events:forEach(function(event, pos)
    if event.name == name or check(event, name) then
      self._events:pop(pos)
      return self:removeListener(event.__class.__name, event.execute)
    end
  end)
end
helper.removePlugin = function(self, name)
  self:removeCommand('', function(com)
    return com.parent == name
  end)
  return self:removeEvent('', function(event)
    return event.parent == name
  end)
end
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
get.ready = function(self)
  return self._ready
end
get.prefix = function(self)
  return self._prefix
end
get.errors = function(self)
  return self._errors
end
return helper
