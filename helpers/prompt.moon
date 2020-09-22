----
-- A prompt helper class
-- @classmod prompt

embed = require '../structures/embed'

prompts = {}

globalActions = {
  check: (content,prompt) ->
    if content == 'n' or content == 'no'
      prompt\reply 'Closing prompt, open again to correct'
      prompt\close!
    elseif content == 'y' or content == 'yes'
      prompt\next!
    else
      prompt\redo! 
}

class
  @__name = 'Prompt'
  --- Construct a prompt to get user information
  -- @param msg The message
  -- @param client A Discordia or Comrade client
  -- @tparam config config A config containing the tasks, timeout, and if its an embed 
  new: (msg,client,config) =>
    return msg\reply 'Finish the currently open prompt' if prompts[msg.author.id]

    prompts[msg.author.id] = true

    @id = msg.author.id

    @stage = 0
    @data = {}

    @message = nil

    @channel = msg.channel
    @client = client

    @tasks = config.tasks
    @timeout = config.timeout or 30000

    @embed = config.embed or false

    @closed = false

    @co = coroutine.create () ->
      loop = () ->
        called, msg = client\waitFor 'messageCreate', @timeout, (recieved) ->
          recieved.author.id == msg.author.id and not @closed
        unless called
          @channel\send 'Closing prompt!' unless @closed
          @close! unless @closed
        else
          @handle msg
          loop!
      loop!

    @next!

    coroutine.resume @co

  -- Progression

  --- Move on the prompt
  next: () =>
    @stage += 1
    @update!

  --- Go back on the prompt
  back: () =>
    @stage -= 1
    @update!

  --- Redo the current prompt task
  redo: () =>
    @update!

  --- Close the prompt
  close: () =>
    @closed = true

    prompts[@id] = false

  --- Send a message in the prompt channel
  reply: (content) =>
    @channel\send content
  
  --- Save a value into the prompt
  save: (key,value) =>
    @data[key] = value

  --- Get a value from the prompt
  get: (key) =>
    @data[key]

  --- Internal; Handle the action
  handle: (msg = {}) =>
    if globalActions[@tasks[@stage].action]
      globalActions[@tasks[@stage].action] msg.content, @, msg
    else
      @tasks[@stage].action msg.content or nil, @, msg

  -- Sending

  --- Internal; Handle the message
  update: () =>
    message = @tasks[@stage].message
    unless @message
      return @channel\send 'Error: No tasks found' unless @tasks[@stage]
      if @embed
        @message = message\send @channel
      else 
        @message = @channel\send message
    else
      return @channel\send 'Error: Prompt out of tasks' unless @tasks[@stage]
      if message == 'check'
        desc = ""
        for i,v in pairs @data
          desc = "#{desc}\n#{i}: #{v}" unless i\sub(0,1) == '_'

        if @embed
          correct = embed!
          correct\setTitle 'Is this correct? [y/yes | n/no]'
          correct\setDescription desc
          correct\setColor 0xee5253

          correct\send @channel
        else
          @message\reply "Is this correct? [y/yes | n/no]\n\n#{desc}"
      elseif message == 'now'
        @handle!
      elseif message ~= 'none'
        if @embed 
          unless message.render
            message\send @channel
          else
            local get

            unless message.usingEtLua
              get = (text, render) ->
                render @get text
            else
              get = (text) ->
                @get text
            
            message\render({
              :get
              step: @step
              timeout: @timeout
            })\send @channel
        else 
          @message\reply message

--- Prompt global actions
-- @param check A function that prompts the user to check their input data, to make data private prefix it with an underscore
-- @table globalActions

--- Prompt configuration
-- @tparam boolean embed
-- @tparam task[] tasks
-- @table config

--- A prompt task
-- @tparam string|table message The message of the task, if the embed flag is set, message has to be embed
-- @tparam string|function action If its a string, it has to be in global actions. Calls function with message content, prompt, and message object
-- @table task