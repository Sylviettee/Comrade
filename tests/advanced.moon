import Command, ArgParse from require '../init'

class test extends Command
  new: =>
    super!
    @addMiddleware ArgParse { -- No changes needed to pre-existing commands
      {
        id: 'numOne'
        type: 'int'
      },
      {
        id: 'numTwo'
        type: 'int'
        default: 0
      },
      {
        id: 'member'
        type: 'member'
        default: (msg) ->
          msg.member
      }
    }, @
  execute: (msg, args) => -- Middleware is passed what a command is parsed and as they are all tables, they use refrences. This means it just works
    -- Parses args into a table
    sum = args.numOne + args.numTwo
    msg\reply "The sum is #{sum} and the member is #{args.member.user.tag}!"
