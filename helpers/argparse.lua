local gmatch
gmatch = require('rex').gmatch
local Array = require('../structures/array')
local split
split = function(str)
  local args = { }
  for i in gmatch(str, [[(?|"(.+?)"|'(.+?)'|(\S+))]]) do
    table.insert(args, i)
  end
  return args
end
local isSnowflake
isSnowflake = function(id)
  return type(id) == 'string' and #id >= 17 and #id <= 64 and not id:match('%D')
end
do
  local _class_0
  local _base_0 = {
    execute = function(self, msg, args)
      local parsed = { }
      for _, value in pairs(self.args) do
        local default
        if type(value.default) == 'function' then
          default = value.default(msg)
        else
          default = value.default
        end
        table.insert(parsed, {
          default = default,
          id = value.id,
          type = self.__class:typeParser(value.type)
        })
      end
      local newArgs = split(table.concat(args, ' '))
      local invalid = ''
      local toReturn = { }
      for i, v in pairs(parsed) do
        local data = newArgs[i]
        if not (data) then
          if v.default then
            data = v.default
          else
            invalid = invalid .. "\n - No argument for `" .. tostring(v.id) .. "`"
          end
        end
        if data then
          local itemType = v.type(tostring(data), msg)
          if itemType == nil then
            invalid = invalid .. "\n - Invalid type for `" .. tostring(v.id) .. "`"
          else
            toReturn[v.id] = itemType
          end
        end
      end
      if not (invalid == '') then
        msg:reply("Failed to run command" .. tostring(invalid))
        return nil, {
          invalid = true
        }
      else
        return toReturn
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, tbl, command)
      if tbl == nil then
        tbl = { }
      end
      self.args = Array(unpack(tbl))
      if command then
        local required = self.args:filter(function(arg)
          return arg.default == nil
        end)
        local optional = self.args:filter(function(arg)
          return arg.default ~= nil
        end)
        command.usage = tostring(command.name) .. tostring((#required > 0 and '<' .. table.concat((function()
          local _accum_0 = { }
          local _len_0 = 1
          for _, x in pairs(required) do
            _accum_0[_len_0] = x.id
            _len_0 = _len_0 + 1
          end
          return _accum_0
        end)(), ', ') .. '>') or '') .. " " .. tostring((#optional > 0 and '[' .. table.concat((function()
          local _accum_0 = { }
          local _len_0 = 1
          for _, x in pairs(optional) do
            _accum_0[_len_0] = x.id
            _len_0 = _len_0 + 1
          end
          return _accum_0
        end)(), ', ') .. ']') or '')
      end
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
  self.__name = "Parser"
  self.types = {
    int = function(val)
      return tonumber(val)
    end,
    string = function(val)
      return (tonumber(val) and nil) or val
    end,
    boolean = function(val)
      return (val == 'true' and true) or (val == 'false' and false) or nil
    end,
    ban = function(val, msg)
      local id = val:match('%d+') or val:match('<@%!?(%d+)>')
      if not (isSnowflake(id)) then
        return nil
      end
      return msg.guild and msg.guild:getBans():get(id)
    end,
    channel = function(val, msg)
      local id = val:match('%d') or val:match('<#(%d+)>')
      if not (isSnowflake(id)) then
        return nil
      end
      return msg.guild and msg.guild.textChannels:get(id)
    end,
    emoji = function(val, msg)
      local id = val:match('<a?:%S+:(%d+)>')
      if not (isSnowflake(id)) then
        return nil
      end
      return msg.mentionedEmojis:get(id)
    end,
    guild = function(val, msg)
      local snowflake = val:match('%d+')
      local name = val:match('.+')
      if snowflake and isSnowflake(snowflake) then
        return msg.client:getGuild(snowflake)
      elseif #name >= 2 and #name <= 100 then
        return msg.client.guilds:find(function(guild)
          return guild.name:lower():find(name:lower(), 1, true)
        end)
      else
        return nil
      end
    end,
    invite = function(val, msg)
      local plain = val:match('[a-zA-Z0-9]+')
      local short = val:match('discord%.gg/([a-zA-Z0-9]+)')
      local full = val:match('https?://discord%.gg/([a-zA-Z0-9]+)')
      return msg.client:getInvite(plain or short or full)
    end,
    member = function(val, msg)
      local id = val:match('<@%!?(%d+)>') or val:match('%d+')
      if not (isSnowflake(id)) then
        return nil
      end
      return msg.guild and msg.guild:getMember(id)
    end,
    message = function(val, msg)
      local guildId, channelId, messageLink = val:match('https?://discord[app]*%.com/channels/(%d+)/(%d+)/(%d+)')
      local messageId = messageLink or val:match('%d+')
      if not (isSnowflake(messageId)) then
        return nil
      end
      local guild = msg.guild
      local channel = msg.channel
      if channelId ~= channel.id or guild.id ~= guildId then
        if isSnowflake(channelId) then
          channel = msg.client:getChannel(channelId)
        end
        if not (channel) then
          return nil
        end
      end
      return messageId and channel:getMessage(messageId)
    end,
    role = function(val, msg)
      local id = val:match('<@&(%d+)>') or val:match('%d+')
      local name = val:match('.+')
      if name and not id and msg.guild then
        return msg.guild.roles:find(function(r)
          return r.name:lower():find(name:lower(), 1, true)
        end)
      end
      return msg.client:getRole(id) or msg.guild and msg.guild:getRole(id) or nil
    end,
    textchannel = function(val, msg)
      local id = val:match('<#(%d+)>') or val:match('%d+')
      local name = val:match('[%S%-]+')
      local guild = msg.guild
      local channel
      if id and isSnowflake(id) then
        channel = msg.client:getChannel(id)
      elseif name then
        channel = guild.textChannels:find(function(chan)
          return chan.name:lower() == name:lower()
        end)
      end
      local types = {
        'TextChannel',
        'GuildTextChannel'
      }
      return channel and table.find(types, channel.__name) and channel
    end,
    user = function(val, msg)
      local id = val:match('<@%!?(%d+)>') or val:match('%d+')
      if not (isSnowflake(id)) then
        return nil
      end
      return msg.client:getUser(id)
    end
  }
  self.typeParser = function(self, val)
    if self.types[val] then
      return self.types[val]
    else
      return val
    end
  end
  return _class_0
end
