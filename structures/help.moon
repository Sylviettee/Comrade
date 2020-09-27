----
-- The default help, extends command
-- @classmod help

command = require './command'
embed = require './embed'

class help extends command
  --- Sets the usage, example, and description of the command
  new: =>
    super!

    @usage = '[all | command name]'
    @example = "#{@name} all"
    @description = 'The help command to give you all the commands'
  --- Returns a list of all the commands
  all: (msg,_,client) =>
    helpEmbed = embed!\setTitle('Help')

    desc = ''

    client.commands\forEach (command) ->
      desc = "#{desc}, `#{command.name}`"

    desc = desc\sub(2,#desc)

    helpEmbed\setDescription desc

    helpEmbed\send msg.channel
  --- Search for the command giving if one was given
  execute: (msg,args,client) =>
    unless args[1]
      @all msg,args,client
    else
      command = client.commands\find (com) ->
        com.name == args[1] or table.search com.aliases, args[1]

      if command
        command\help msg.channel
      else
        msg\reply 'Could\'t find that command'

help!