local get
get = require('../init').get
local embed = require('./embed')
local util = require('../helpers/util')
local setTimeout
setTimeout = require('timer').setTimeout
local Date
Date = require('discordia').Date
local concatIndex
concatIndex = function(tbl, sep)
  if sep == nil then
    sep = ', '
  end
  local val = ''
  for i, _ in pairs(tbl) do
    val = tostring(val) .. tostring(i) .. tostring(sep)
  end
  return val:sub(0, #val - #sep)
end
local command
do
  local _class_0
  local _base_0 = {
    help = function(self, channel)
      local helpEmbed = embed():setTitle('Help'):addFields({
        'Description',
        self.description
      }, {
        'Aliases',
        (table.concat(self.aliases, ', ') == '' and 'None') or (table.concat(self.aliases, ', ') ~= '' and table.concat(self.aliases, ', '))
      }, {
        'Subcommands',
        (concatIndex(self.subcommands, ', ') == '' and 'None') or (concatIndex(self.subcommands, ', ') ~= '' and concatIndex(self.subcommands, ', '))
      }, {
        'Usage',
        self.usage
      }, {
        'Example',
        self.example
      })
      return helpEmbed:send(channel)
    end,
    pre = function(self)
      intAssert(self.name, 'No name found')
      intAssert(self.execute, 'No execute command found')
      self.aliases = { }
      self.permissions = { }
      self.subcommands = { }
      self.cooldowns = { }
      self.allowDMS = false
      self.hidden = false
      self.description = 'None'
      self.usage = tostring(self.name)
      self.example = tostring(self.name)
      local ignore = {
        'pre',
        'new',
        'check',
        'run',
        'execute'
      }
      for i, v in pairs(self.__class.__base) do
        if type(v) == 'function' then
          if not (table.search(ignore, i)) then
            self.subcommands[i] = v
          end
        end
      end
      if #self.permissions > 0 then
        self.allowDMS = false
      end
      if self.preconditions then
        return self:preconditions()
      end
    end,
    check = function(self, command, msg, client)
      local isValid = command:lower() == self.name or table.search(self.aliases, command:lower())
      if not (isValid) then
        return false
      end
      isValid = not (self.allowDMS and msg.channel.type == 1)
      if not (isValid) then
        return false
      end
      if self.hidden then
        if not (table.search(client.owners, msg.author.id)) then
          return false
        end
      end
      if not (self.allowDMS) then
        isValid = util.checkPerm(msg.member, msg.channel, self.permissions)
      end
      if not (isValid) then
        return false
      end
      if self.cooldown then
        if self.cooldowns[msg.author.id] then
          local secondsLeft = self.cooldown - (self.cooldowns[msg.author.id] - Date()):toMilliseconds()
          msg:reply("You are on cooldown, " .. tostring(util.formatLong(secondsLeft)) .. " left.")
          return false
        else
          self.cooldowns[msg.author.id] = Date()
          setTimeout(self.cooldown, function()
            self.cooldowns[msg.author.id] = false
          end)
        end
      end
      return isValid
    end,
    run = function(self, msg, args, client)
      local subcommand = args[1]
      if self.subcommands[subcommand] then
        args = table.slice(args, 2)
        return self.subcommands[subcommand](msg, args, client)
      else
        return self:execute(msg, args, client)
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.name = self.__class.__name or '_temp_'
      return self:pre()
    end,
    __base = _base_0,
    __name = "command"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  command = _class_0
  return _class_0
end
