local embed = require('./embed')
local util = require('../helpers/util')
local setTimeout
setTimeout = require('timer').setTimeout
local Date
Date = require('discordia').Date
do
  local _class_0
  local _base_0 = {
    help = function(self, channel)
      if not (self.formatted) then
        local formatted = ''
        if type(self.example) == 'string' then
          self.example = {
            self.example
          }
        end
        for i, v in pairs(self.example) do
          formatted = formatted .. tostring(i) .. ". " .. tostring(v) .. "\n"
        end
        self.formatted = formatted
      end
      local helpEmbed = embed():setTitle('Help'):addFields({
        'Description',
        self.description
      }, {
        'Aliases',
        (table.concat(self.aliases, ', ') == '' and 'None') or (table.concat(self.aliases, ', ') ~= '' and table.concat(self.aliases, ', '))
      }, {
        'Subcommands',
        (table.concatIndex(self.subcommands, ', ') == '' and 'None') or (table.concatIndex(self.subcommands, ', ') ~= '' and table.concatIndex(self.subcommands, ', '))
      }, {
        'Usage',
        self.usage
      }, {
        'Example',
        self.formatted
      })
      return helpEmbed:send(channel)
    end,
    pre = function(self)
      assert(self.name, 'No name found')
      assert(self.execute, 'No execute command found')
      self.aliases = { }
      self.permissions = { }
      self.subcommands = { }
      self.cooldowns = { }
      self.errors = { }
      self.tested = { }
      self.allowDMS = false
      self.hidden = false
      self.description = 'None'
      self.usage = tostring(self.name)
      self.example = {
        tostring(self.name)
      }
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
      if (self.preconditions and self:preconditions(msg, args, client)) or true then
        local subcommand = args[1]
        local ran = self.subcommands[subcommand] and subcommand or 'main'
        local succ, err
        if self.subcommands[subcommand] then
          args = table.slice(args, 2)
          succ, err = pcall(self.subcommands[subcommand], self, msg, args, client)
        else
          succ, err = pcall(self.execute, self, msg, args, client)
        end
        if not (succ) then
          client:error("Command error: " .. tostring(err))
          if not (self.errors[ran]) then
            self.errors[ran] = { }
          end
          table.insert(self.errors[ran], err)
        end
        self.tested[ran] = true
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
    __name = nil
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self.__name = 'Command'
  return _class_0
end
