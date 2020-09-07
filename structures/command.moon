----
-- A command helper class, should be extended
-- @classmod command

import get from require '../init'

embed = require './embed'
util = require '../helpers/util'

import setTimeout from require 'timer'

import Date from require 'discordia'

concatIndex = (tbl, sep=', ') ->
  val = ''
  for i,_ in pairs tbl
    val = "#{val}#{i}#{sep}"

  val\sub(0,#val - #sep)

class command
  --- Create a command
  new: () =>
    @name = @@__name or '_temp_'

    @pre!

  --- An function to generate a help embed and send to to a channel
  -- @tparam table channel The channel to send the message to
  help: (channel) =>
    formatted = ''

    @example = {@example} if type(@example) == 'string'

    for i,v in pairs @example
      formatted ..= "#{i}. #{v}\n"

    helpEmbed = embed!\setTitle('Help')\addFields {'Description',@description},
      {'Aliases', (table.concat(@aliases, ', ') == '' and 'None') or (table.concat(@aliases, ', ') != '' and table.concat(@aliases, ', '))},
      {'Subcommands', (concatIndex(@subcommands, ', ') == '' and 'None') or (concatIndex(@subcommands, ', ') != '' and concatIndex(@subcommands, ', '))},
      {'Usage', @usage},
      {'Example', formatted}
      
    helpEmbed\send channel

  --- An internal function to fill in all the data
  pre: () =>
    intAssert @name, 'No name found'
    intAssert @execute, 'No execute command found'
    
    -- Fill in defaults

    @aliases = {}
    @permissions = {} 
    @subcommands = {}
    @cooldowns = {}

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
  --- An internal function to run the command, it will check against preconditions if it exists
  -- @tparam table msg The message that called the command
  -- @tparam string[] args The arguments of the message
  -- @tparam client client The client that called the command
  run: (msg,args,client) =>
    -- Check for sub commands

    if @preconditions and @preconditions msg, args, client
      subcommand = args[1]

      if @subcommands[subcommand]
        args = table.slice args, 2
        @subcommands[subcommand] msg,args,client
      else
        @execute msg,args,client