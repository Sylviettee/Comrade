local embed = require('../structures/embed')
local prompts = {}
local globalActions = {
  check = function(content, prompt)
    if content == 'n' or content == 'no' then
      prompt:reply('Closing prompt, open again to correct')
      return prompt:close()
    elseif content == 'y' or content == 'yes' then
      return prompt:next()
    else
      return prompt:redo()
    end
  end
}
do
  local _class_0
  local _base_0 = {
    next = function(self)
      self.stage = self.stage + 1
      return self:update()
    end,
    back = function(self)
      self.stage = self.stage - 1
      return self:update()
    end,
    redo = function(self) return self:update() end,
    close = function(self)
      self.closed = true
      prompts[self.id] = false
    end,
    reply = function(self, content) return self.channel:send(content) end,
    save = function(self, key, value) self.data[key] = value end,
    get = function(self, key) return self.data[key] end,
    handle = function(self, msg)
      if msg == nil then msg = {} end
      if globalActions[self.tasks[self.stage].action] then
        return globalActions[self.tasks[self.stage].action](msg.content, self, msg)
      else
        return self.tasks[self.stage].action(msg.content or nil, self, msg)
      end
    end,
    update = function(self)
      local message = self.tasks[self.stage].message
      if not (self.message) then
        if not (self.tasks[self.stage]) then return self.channel:send('Error: No tasks found') end
        if self.embed then
          self.message = message:send(self.channel)
        else
          self.message = self.channel:send(message)
        end
      else
        if not (self.tasks[self.stage]) then return self.channel:send('Error: Prompt out of tasks') end
        if message == 'check' then
          local desc = ''
          for i, v in pairs(self.data) do
            if not (i:sub(0, 1) == '_') then
              desc = tostring(desc) .. '\n' .. tostring(i) .. ': ' .. tostring(v)
            end
          end
          if self.embed then
            local correct = embed()
            correct:setTitle('Is this correct? [y/yes | n/no]')
            correct:setDescription(desc)
            correct:setColor(0xee5253)
            return correct:send(self.channel)
          else
            return self.message:reply('Is this correct? [y/yes | n/no]\n\n' .. tostring(desc))
          end
        elseif message == 'now' then
          return self:handle()
        elseif message ~= 'none' then
          if self.embed then
            return message:send(self.channel)
          else
            return self.message:reply(message)
          end
        end
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, msg, client, config)
      if prompts[msg.author.id] then return msg:reply('Finish the currently open prompt') end
      prompts[msg.author.id] = true
      self.id = msg.author.id
      self.stage = 0
      self.data = {}
      self.message = nil
      self.channel = msg.channel
      self.client = client
      self.tasks = config.tasks
      self.timeout = config.timeout or 30000
      self.embed = config.embed or false
      self.closed = false
      self.co = coroutine.create(function()
        local loop
        loop = function()
          local called
          called, msg = client:waitFor('messageCreate', self.timeout, function(recieved)
            return recieved.author.id == msg.author.id and not self.closed
          end)
          if not (called) then
            if not (self.closed) then self.channel:send('Closing prompt!') end
            if not (self.closed) then return self:close() end
          else
            self:handle(msg)
            return loop()
          end
        end
        return loop()
      end)
      self:next()
      return coroutine.resume(self.co)
    end,
    __base = _base_0,
    __name = nil
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self.__name = 'Prompt'
  return _class_0
end
