local Date, enums
do
  local _obj_0 = require('discordia')
  Date, enums = _obj_0.Date, _obj_0.enums
end
do
  local _class_0
  local _base_0 = {
    addField = function(self, name, value, inline)
      if inline == nil then inline = false end
      if not self.embed.fields then self.embed.fields = {} end
      if #self.embed.fields <= 25 then
        if type(name) == 'table' then
          table.insert(self.embed.fields, name)
        else
          name = name:sub(0, 256)
          value = value:sub(0, 1024)
          table.insert(self.embed.fields, {name = name, value = value, inline = inline})
        end
        return self
      end
    end,
    addFields = function(self, ...)
      local fields = {...}
      for _, v in pairs(fields) do
        if not v.name then
          self:addField(unpack(v))
        else
          self:addField(v)
        end
      end
      return self
    end,
    setAuthor = function(self, name, iconURL, url)
      name = name:sub(0, 256)
      self.embed.author = {name = name, ['icon_url'] = iconURL, url = url}
      return self
    end,
    setColor = function(self, color)
      self.embed.color = color
      return self
    end,
    setDescription = function(self, description)
      self.embed.description = description:sub(0, 2048)
      return self
    end,
    setFooter = function(self, text, iconURL)
      text = text:sub(0, 2048)
      self.embed.footer = {text = text, ['icon_url'] = iconURL}
      return self
    end,
    setImage = function(self, url)
      self.embed.image = {url = url}
      return self
    end,
    setThumbnail = function(self, url)
      self.embed.thumbnail = {url = url}
      return self
    end,
    setTimestamp = function(self, timestamp)
      if timestamp == nil then timestamp = Date().toISO() end
      self.embed.timestamp = timestamp
      return self
    end,
    setTitle = function(self, title)
      self.embed.title = title:sub(0, 256)
      return self
    end,
    setURL = function(self, url)
      self.embed.url = url
      return self
    end,
    toJSON = function(self) return self.embed end,
    send = function(self, channel)
      if channel.type == enums.channelType.private then
        return channel:send({embed = self:toJSON()})
      else
        local perms = channel.guild.me:getPermissions(channel)
        if not perms:has(enums.permission.embedLinks) then
          return channel:send('I don\'t have the permissions to send embeds.')
        else
          return channel:send({embed = self:toJSON()})
        end
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, starting)
      if starting == nil then starting = {} end
      self.embed = starting
    end,
    __base = _base_0
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0;
  self.__name = 'embed'
  return _class_0
end
