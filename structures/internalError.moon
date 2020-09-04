----
-- An internal error class to send to the console or the client
-- @classmod internalError

class Error 
  --- Constructs a new error
  -- @tparam string message The message of the error
  -- @tparam ?client client The client of nil
  new: (message, client) =>
    @message = message
    @traceback = debug.traceback!
    @client = client
  
  --- Sends the error to the logs or to the client
  send: () =>
    unless @client
      print "Unhandled Error; \n#{@message}\n#{@traceback}"
      process\exit!
    else
      @client\debug @message
      if @client\getListenerCount('error') > 0
        @client\error @message
      else
        print "Unhandled Error; #{@message}\n#{@traceback}"
        process\exit!