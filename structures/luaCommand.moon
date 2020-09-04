----
-- Makes creating commands with pure lua easier
-- @classmod luaCommand

Command = require './command'

class luaCommand
  --- Takes in the name of the command
  -- @tparam string name Command name
  new: (name) =>
    @name = name
  --- Makes the command, remember that you should set the properties
  make: () =>
    data = @
    class extends Command
      new: () =>
        @@__name = data.name
        for i,v in pairs data
          if i != 'name'
            @[i] = v

        super!