--- A module to parse arguments into a table
-- @see advanced-arguments.moon
-- @module argparse

import gmatch from require 'rex'

Array = require '../structures/array'

split = (str) ->
  args = {}

  for i in gmatch str, [[(?|"(.+?)"|'(.+?)'|(\S+))]]
    table.insert args, i
  args

isSnowflake = (id) ->
  return type(id) == 'string' and
    #id >= 17 and 
    #id <= 64 and 
    not id\match('%D')

class Parser
  @types = {
    int: (val) ->
      return tonumber val
    string: (val) ->
      return (tonumber(val) and nil) or val
    boolean: (val) ->
      return (val == 'true' and true) or (val == 'false' and false) or nil
    -- Discord types --
    ban: (val, msg) ->
      id = val\match('%d+') or val\match('<@%!?(%d+)>')
      return nil unless isSnowflake id
      
      return msg.guild and msg.guild\getBans!\get id
    channel: (val, msg) ->
      id = val\match('%d') or val\match '<#(%d+)>'
      return nil unless isSnowflake id

      return msg.guild and msg.guild.textChannels\get id
    emoji: (val, msg) ->
      id = val\match '<a?:%S+:(%d+)>'
      return nil unless isSnowflake id

      return msg.mentionedEmojis\get id
    guild: (val, msg) ->
      snowflake = val\match '%d+'
      name = val\match '.+'

      if snowflake and isSnowflake snowflake
        return msg.client\getGuild snowflake
      elseif #name >= 2 and #name <= 100
        return msg.client.guilds\find (guild) ->
          guild.name\lower!\find name\lower!, 1, true
      else
        return nil
    invite: (val, msg) ->
      plain = val\match '[a-zA-Z0-9]+'
      short = val\match 'discord%.gg/([a-zA-Z0-9]+)'
      full = val\match 'https?://discord%.gg/([a-zA-Z0-9]+)'

      return msg.client\getInvite plain or short or full
    member: (val, msg) ->
      id = val\match('<@%!?(%d+)>') or val\match '%d+'
      return nil unless isSnowflake id

      return msg.guild and msg.guild\getMember id
    message: (val, msg) ->
      guildId, channelId, messageLink = val\match 'https?://discord[app]*%.com/channels/(%d+)/(%d+)/(%d+)'
      messageId = messageLink or val\match '%d+'

      return nil unless isSnowflake messageId

      guild = msg.guild
      channel = msg.channel

      if channelId != channel.id or guild.id != guildId
        if isSnowflake channelId
          channel = msg.client\getChannel channelId
        
        return nil unless channel
      
      return messageId and channel\getMessage messageId
    role: (val, msg) ->
      id = val\match('<@&(%d+)>') or val\match '%d+'

      name = val\match '.+'

      if name and not id and msg.guild
        return msg.guild.roles\find (r) ->
          r.name\lower!\find name\lower!, 1, true
      
      return msg.client\getRole(id) or msg.guild and msg.guild\getRole(id) or nil
    textchannel: (val, msg) ->
      id = val\match('<#(%d+)>') or val\match '%d+'
      name = val\match '[%S%-]+'

      guild = msg.guild

      local channel

      if id and isSnowflake id
        channel = msg.client\getChannel id
      elseif name
        channel = guild.textChannels\find (chan) ->
          chan.name\lower! == name\lower!
      
      types = {'TextChannel', 'GuildTextChannel'}

      return channel and table.find(types, channel.__name) and channel
    user: (val, msg) ->
      id = val\match('<@%!?(%d+)>') or val\match '%d+'
      return nil unless isSnowflake id

      return msg.client\getUser id
  }
  @typeParser: (val) =>
    if @types[val] 
      return @types[val]
    else 
      return val
  --- Construct an argument parser
  -- @tparam argument[] tbl The argument table to parse
  -- @tparam command command The command which you are using this on
  new: (tbl = {}, command) =>
    @args = Array unpack tbl

    if command
      -- Set the arguments as we have them already
      required = @args\filter (arg) ->
        arg.default == nil
      
      optional = @args\filter (arg) ->
        arg.default != nil
      
      command.usage = "#{command.name}#{(#required > 0 and '<' .. table.concat([x.id for _,x in pairs required], ', ') .. '>') or ''} #{(#optional > 0 and '[' .. table.concat([x.id for _,x in pairs optional], ', ') .. ']') or ''}"
     
  execute: (msg, args) =>
    -- Load defaults --
    parsed = {}
    for _,value in pairs @args
      local default
      if type(value.default) == 'function'
        default = value.default msg
      else
        default = value.default
      
      table.insert parsed, {
        :default
        id: value.id
        type: @@typeParser value.type
      }
    
    newArgs = split table.concat args, ' '

    invalid = ''
    toReturn = {}

    for i,v in pairs parsed
      data = newArgs[i]
      unless data
        if v.default
          data = v.default
        else
          -- Add to invalid list to send to user
          invalid ..= "\n - No argument for `#{v.id}`"
          continue -- Can't run checks against nil

      itemType = v.type tostring(data), msg

      if itemType == nil
        invalid ..= "\n - Invalid type for `#{v.id}`"
      else
        -- Passed all the checks
        toReturn[v.id] = itemType

    unless invalid == ''
      msg\reply "Failed to run command#{invalid}"
      
      return nil, {
        invalid: true
      }
    else
      return toReturn
      
--- An argument
-- @tparam string id The key of where to put the argument
-- @tparam string type The type of the argument
-- @tparam[opt=nil] string|function default The default argument, if passed a function it will be passed the argument and message
-- @table argument

--- The built in types; They are automatically type casted to what they are named
-- @param int Check if the input is a number
-- @param string Does nothing as all inputs are strings
-- @param boolean Check if the input is true or false
-- @param ban Check if the input is a valid ban
-- @param channel Check if the input is a channel; does not allow searching
-- @param emoji Check if the input is a emoji
-- @param guild Check if the input is a guild, will preform a search if the input is a string
-- @param invite Check if the input is a invite code
-- @param member Check if the input is a member; does not allow searching
-- @param message Check if the input is message jump link or an id
-- @param role Check if the input is a role, will preform a search if the input is a string
-- @param textchannel Check if the input is a text channel, will preform a search if the input is a string
-- @Param user Check if the input is a valid user