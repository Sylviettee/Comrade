----
-- A command helper class, should be extended
-- @classmod command
embed = require './embed'
util = require '../helpers/util'

import setTimeout from require 'timer'

import Date from require 'discordia'

class
  @__name = 'Command'
  --- Create a command
  new: =>
    @name = @@__name or '_temp_'

    @pre!

  --- An function to generate a help embed and send to to a channel
  -- @tparam table channel The channel to send the message to
  help: (channel) =>
    unless @formatted
      formatted = ''

      @example = {@example} if type(@example) == 'string'

      for i,v in pairs @example
        formatted ..= "#{i}. #{v}\n"

      @formatted = formatted

    helpEmbed = embed!\setTitle('Help')\addFields {'Description',@description},
      {'Aliases', 
        (table.concat(@aliases, ', ') == '' and 'None') or 
        (table.concat(@aliases, ', ') != '' and table.concat(@aliases, ', '))
      },
      {'Subcommands', 
        (table.concatIndex(@subcommands, ', ') == '' and 'None') or 
        (table.concatIndex(@subcommands, ', ') != '' and table.concatIndex(@subcommands, ', '))
      },
      {'Usage', @usage},
      {'Example', @formatted}
      
    helpEmbed\send channel

  --- An internal function to fill in all the data
  pre: =>
    assert @name, 'No name found'
    assert @execute, 'No execute command found'
    
    -- Fill in defaults

    @aliases = {}
    @permissions = {} 
    @subcommands = {}
    @cooldowns = {}
    @errors = {}
    @tested = {}
    @middleware = {}

    @allowDMS = false
    @hidden = false

    @description = 'None'
    @usage = "#{@name}"
    @example = {"#{@name}"}

    ignore = {'pre', 'new', 'check', 'run', 'execute'}

    for i,v in pairs @@.__base
      if type(v) == 'function'
        unless table.search ignore, i
          @subcommands[i] = v

    if #@permissions > 0
      @allowDMS = false

  --- An internal function to check if the message fits the command
  -- @tparam string command The command without arguments or prefix
  -- @tparam table msg The message that called the command
  -- @tparam client client The client using the command
  check: (command,msg,client) => 
    isValid = command\lower! == @name or table.search @aliases,command\lower!

    return false unless isValid

    isValid = not (@allowDMS and msg.channel.type == 1)

    return false unless isValid

    if @hidden
      return false unless table.search(client.owners,msg.author.id)

    unless @allowDMS
      isValid = util.checkPerm msg.member, msg.channel, @permissions

    return false unless isValid

    if @cooldown
      if @cooldowns[msg.author.id]
        secondsLeft = @cooldown - (@cooldowns[msg.author.id] - Date!)\toMilliseconds!

        msg\reply "You are on cooldown, #{util.formatLong secondsLeft} left."
        return false
      else
        @cooldowns[msg.author.id] = Date!
        setTimeout @cooldown, () ->
          @cooldowns[msg.author.id] = false

    isValid

  --- A function that can be used to add extra functionality to commands like more advanced argument parsing
  -- @tparam middleware middleware The middleware to add, should have execute function
  addMiddleware: (middleware) =>
    table.insert @middleware, middleware
  --- An internal function to run the command, it will check against preconditions if it exists
  -- @tparam table msg The message that called the command
  -- @tparam string[] args The arguments of the message
  -- @tparam client client The client that called the command
  run: (msg,args,client) =>
    -- Check for sub commands

    if (@preconditions and @preconditions msg, args, client) or true
      subcommand = args[1]

      ran = @subcommands[subcommand] and subcommand or 'main'

      local succ, err

      local toRun

      if @subcommands[subcommand]
        args = table.slice args, 2
        toRun = @subcommands[subcommand]
      else
        toRun = @execute

      -- Run middleware --
      for _,v in pairs @middleware
        args, res = v\execute msg,args,client
        if res and res.invalid
          return -- Stop execution

      succ, err = pcall toRun, @, msg,args,client

      unless succ
        client\error "Command error: #{err}"

        @errors[ran] = {} unless @errors[ran]

        table.insert @errors[ran], err
      
      @tested[ran] = true