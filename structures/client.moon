----
-- The helper client, extends a Discordia client
-- @field token
-- @classmod client

import version from require '../init'

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

  -- Testing
  @_testing = config.testing or config.testbot or false
  @_testbot = config.testbot or false
  @_botid = config.botid or nil

  @_errors = (@_testing or config.storeErrors) and {}
  @_ready = false

  if @_botid
    table.insert @_owners, @_botid -- Testing bot should be owner

  @_start = os.time!

  @_commands = array!
  @_events = array!
  @_plugins = array!

  @_events = array!

  @\on 'ready', () ->
    @_ready = true
    @\info "Ready as #{@user.tag}"

    if @_defaultHelp
      @addCommand require './help'
    
    if @_testing
      @addCommand require './status'

  unless @_testbot
    @\on 'messageCreate', (msg) ->
      return nil unless string.startswith(msg.content,@_prefix)     
      if msg.author.bot and msg.author.id != @_botid
        return nil 

      perms = msg.guild.me\getPermissions msg.channel
      
      return @\debug "Comrade : No send messages" unless perms\has enums.permission.sendMessages -- If we can't send messages then just reject

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

        unless succ
          @\debug "Comrade : Error #{err}"
          @\error err

--- Login to Discord
-- @tparam table status
helper.login = (status) =>
  @run "Bot #{@_token}"
  if status
    @setGame status

helper.info = (...) =>
  unless @_testing
    @_logger\log 3, ...

  @\emit 'info', string.format ...

helper.error = (...) =>
  unless @_testing
    @_logger\log 1, ...

  @\emit 'error', string.format ...
  
  if @_errors
    table.insert @_errors, string.format ...

--- Reset the errors back to an empty array
helper.resetErrors = () =>
  @_errors = {}

--- Update the owners list
-- @tparam table owners
helper.updateOwners = (owners) =>
  @_owners = owners

--- Add a command
-- @tparam command command
-- @see command
helper.addCommand = (command) =>
  @\debug "Comrade: New command #{command.name}"
  @_commands\push command

--- Remove a command
-- @tparam string name
-- @tparam ?function check
helper.removeCommand = (name, check = () -> false) =>
  @_commands\forEach (command, pos) ->
    if command.name == name or check command, name
      @_commands\pop pos

--- Add an event
-- @tparam event event
-- @see event
helper.addEvent = (event) =>
  @\debug "Comrade: New listener #{event.name}"
  event\use @
  @_events\push event

--- Remove an event
-- @tparam string name
-- @tparam ?function check
helper.removeEvent = (name, check = () -> false) =>
  @_events\forEach (event, pos) ->
    if event.name == name or check event, name
      @_events\pop pos
      @\removeListener event.__class.__name, event.execute

--- Remove plugin
-- @tparam string name
helper.removePlugin = (name) =>
  @removeCommand '', (com) ->
    com.parent == name
  @removeEvent '', (event) ->
    event.parent == name

get.start = () =>
  @_start
get.commands = () =>
  @_commands
get.version = () ->
  version
get.owners = () =>
  @_owners
get.ready = () =>
  @_ready
get.prefix = () =>
  @_prefix
get.errors = () =>
  @_errors

helper

-- TODO; add testing stuff

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