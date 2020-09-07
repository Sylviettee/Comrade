----
-- An event class, should be extended
-- @classmod event
class event
  --- Create an event, class should have execute field
  new: () =>
    intAssert @execute, 'No execution for event was found'

    @name = @@__name
  
  --- Use the event, takes in a client object
  -- @tparam client client The client your going to listen on
  use: (client) =>
    unless @once
      client\on @name, @execute
    else
      client\once @name, @execute