----
-- The helper client, extends a Discordia client
-- @field token
-- @classmod client

import get, version, name from require '../init'

internalError = require './internalError'
array = require './array'

discordia = require 'discordia'

import enums from discordia

Class,Client = discordia.class,discordia.Client

helper,get = Class 'Helper Client', Client

options = {
	'routeDelay'
	'maxRetries'
	'shardCount'
	'firstShard'
	'lastShard'
	'largeThreshold'
	'cacheAllMembers'
	'autoReconnect'
	'compress'
	'bitrate'
	'logFile'
	'logLevel'
	'gatewayFile'
	'dateTime'
	'syncGuilds'
}

--- Create a new helper client
-- @tparam string token The Discord bot token
-- @tparam[opt={}] config config The configuration of the client
helper.__init = (token,config={}) =>
  clientConfig = {}

  for i,v in pairs config
    if table.search options, i
      clientConfig[i] = v

  Client.__init(@, clientConfig)

  assert token, 'A token is required!'
  @_token = token
  @_prefix = config.prefix or '!'

  @_defaultHelp = config.defaultHelp or true
  @_owners = config.owners or {}

  @_start = os.time!

  @_commands = array!
  @_plugins = array!

  @_events = array!

  _G.intAssert = (condition, message='Condition is false') ->
    unless condition
      internalError(message, @)\send!
  _G.intError = (message) ->
    internalError(message, @)\send!

  @\on 'ready', () ->
    @\info "Ready as #{@user.tag}"

    if @_defaultHelp
      @addCommand require './help'

  @\on 'messageCreate', (msg) ->
    unless string.startswith(msg.content,@_prefix)
      return nil

    perms = msg.guild.me\getPermissions msg.channel
    
    unless perms\has enums.permission.sendMessages -- If we can't send messages then just reject
      @\debug "Comrade : No send messages"
      return nil

    command = string.split msg.content, ' '

    command = string.gsub command[1],@_prefix, ''

    args = table.slice(string.split(msg.content, ' '), 2)

    command = command\lower!

    found = @_commands\find (val) ->
      val\check command,msg, @

    if found
      @\debug "Comrade : Ran #{command}"
      succ,err = pcall () -> 
        found\run msg,args, @
      if not succ
        @\debug "Comrade : Error #{err}"
        intError err

--- Login to Discord
helper.login = (status) =>
  @run "Bot #{@_token}"
  if status
    @setGame status

--- Add a command
-- @tparam command command
-- @see command
helper.addCommand = (command) =>
  @\debug "Comrade: New command #{command.name}"
  @_commands\push command

--- Remove a command
-- @tparam string name
helper.removeCommand = (name) =>
  @_commands\forEach (command, pos) ->
    if command.parent == name or command.name == name
      @_commands\pop pos

--- Add an event
-- @tparam event event
-- @see event
helper.addEvent = (event) =>
  @\debug "Comrade: New listener #{event.name}"
  event\use @
  @_events\push event

get.start = () =>
  @_start
get.commands = () =>
  @_commands
get.version = () ->
  version
get.owners = () =>
  @_owners

helper

--- The clients configuration (Most from Discordia client)
-- @tparam[opt='!'] string prefix The prefix the bot will use
-- @tparam[opt=true] boolean defaultHelp Whether to use the default help or not
-- @tparam[opt={}] table owners The owners of this bot
-- @tparam[opt=300] number routeDelay Minimum time in milliseconds to wait between HTTP requests per-route
-- @tparam[opt=5] number maxRetries The maximum number of retries to attempt after an HTTP request fails
-- @tparam[opt=0] number shardCount The total number of shards the application is using (0 signals to use the recommended count)
-- @tparam[opt=0] number firstShard The ID of the first shard to run on the client (0 is the minimum)
-- @tparam[opt=-1] number lastShard The ID of the last shard to run on the client (-1 signals to use shardCount - 1)
-- @tparam[opt=100] number largeThreshold Limit to how many members are initially fetched per-guild on start-up
-- @tparam[opt=false] boolean cacheAllMembers Whether to cache all members (If false, offline members may not be cached)
-- @tparam[opt=true] boolean autoReconnect Whether to attempt to reconnect after an unexpected gateway disconnection
-- @tparam[opt=true] boolean compress Whether to allow for compressed gateway payloads
-- @tparam[opt=64000] number bitrate The default bitrate to use for voice connections, from 8000 to 128000
-- @tparam[opt='discordia.log'] string logFile The file to use for logging
-- @tparam[opt=logLevel.info] string logLevel The level to use for logging (see Enumerations)
-- @tparam[opt='%F %T'] string dateTime The date and time format to use logging
-- @tparam[opt=false] boolean syncGuilds Whether to automatically sync all guilds on start up (user-accounts only)
-- @table config