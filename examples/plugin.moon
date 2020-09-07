import plugin from require 'comrade'

class pluginname extends plugin
  new: () =>
    super!
    
    class commandname extends @command -- Plugins hold a command method which automatically registers itself to the plugin
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
    
    class messageCreate extends @event -- They also hold an event, class name should be the event name
      execute: (msg) => -- No need for super, arguments are the event arguments
        p msg

return pluginname!