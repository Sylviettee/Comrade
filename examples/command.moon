import Command from require 'comrade'

class commandname extends Command
  new: () =>
    super!

    @name = '' -- Override class name
    @aliases = {''}
    @permissions = {''} -- Uses overrides like if they have Moderation we can override them not having kick members
    @hidden = false -- It won't appear in help and can only be ran by an owner
    @allowDMS = false
    @cooldown = 3000 -- Comes in with a built in MS parser so it can say '3 minutes remaining' or '3 hours'

    @description = ''
    @usage = ''
    @example = ''
  
  subcommand: (msg, args, client) =>
    -- I only run when you say commandname subcommand
    msg\reply 'Subcommand!'

  execute: (msg, args, client) =>
    -- Command logic
    @help msg.channel -- Send the help message

commandname!