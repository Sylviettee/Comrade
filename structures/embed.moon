----
-- A embed helper class
-- @classmod embed
import Date, enums from require 'discordia'

class
  @__name = 'embed' -- No unused variables
  --- Create an embed, can be passed a table as a starting point
  -- @tparam[opt={}] table starting Where the internal embed starts
  new: (starting = {}) =>
    @embed = starting
  
  --- Add a field to the embed with name, value, and inline
  -- @tparam field|string name The name of the field or an embed object
  -- @tparam ?string value The value of the field, optional if name is field
  -- @tparam[opt=false] boolean inline If the field is inline
  -- @treturn embed
  addField: (name,value,inline = false) =>
    @embed.fields = {} unless @embed.fields

    if #@embed.fields <= 25
      if type(name) == 'table'
        table.insert @embed.fields, name
      else

        name = name\sub 0, 256
        value = value\sub 0, 1024

        table.insert @embed.fields, {
          :name,
          :value,
          :inline
        }

      @
  --- Add fields to the embed
  -- @tparam {field,...}|{name,value,inline}... fields The fields to add, max 25
  -- @treturn embed
  addFields: (...) =>
    fields = {...}

    for _,v in pairs fields
      unless v.name
        @addField unpack v
      else
        @addField v

    @
  
  --- Set the author of the embed
  -- @tparam string name The author name
  -- @tparam ?string iconURL The icon of the author
  -- @tparam ?string url The url of the author
  -- @treturn embed
  setAuthor: (name, iconURL, url) =>
    name = name\sub 0, 256
    @embed.author = {
      :name,
      'icon_url': iconURL,
      :url
    }

    @
  
  --- Set the color of the embed
  -- @tparam hex color The color in hex eg 0xFFFFFF
  -- @treturn embed
  setColor: (color) =>
    @embed.color = color

    @
  
  --- Set the description of the embed
  -- @tparam string description The description of the embed
  -- @treturn embed
  setDescription: (description) =>
    @embed.description = description\sub 0, 2048

    @
  
  --- Set the footer of the embed
  -- @tparam string text The footer text
  -- @tparam ?string iconURL The icon of the footer
  -- @treturn embed
  setFooter: (text, iconURL) =>
    text = text\sub 0, 2048
    @embed.footer = {
      :text,
      'icon_url': iconURL
    }

    @
  
  --- Set the image of the embed
  -- @tparam string url The image url of the embed
  -- @treturn embed
  setImage: (url) =>
    @embed.image = {
      :url
    }

    @
  
  --- Set the thumbnail of the embed
  -- @tparam string url The thumbnail url of the embed
  -- @treturn embed
  setThumbnail: (url) =>
    @embed.thumbnail = {
      :url
    }

    @
  
  --- Set the timestamp of the embed, defaults to right now
  -- @tparam[opt=Date().toISO()] string timestamp The timestamp in ISO 8601
  -- @treturn embed
  setTimestamp: (timestamp = Date().toISO()) =>
    @embed.timestamp = timestamp

    @
  
  --- Set the title of the embed
  -- @tparam string title The title of the embed
  -- @treturn embed
  setTitle: (title) =>
    @embed.title = title\sub 0, 256

    @
  
  --- Set the url of the embed
  -- @tparam string url The url of the embed
  -- @treturn embed
  setURL: (url) =>
    @embed.url = url

    @
  
  --- Returns the embed object without any metatables
  -- @treturn table
  toJSON: () =>
    @embed
  
  --- Sends the embed and checks if we have permissions to
  -- @tparam table channel The channel to send the embed into
  send: (channel) =>
    -- Check if we can send

    if channel.type == enums.channelType.private
      return channel\send {
        embed: @toJSON!
      }
    else
      perms = channel.guild.me\getPermissions channel

      unless perms\has enums.permission.embedLinks -- Can't send embeds
        return channel\send 'I don\'t have the permissions to send embeds.'
      else
        return channel\send {
          embed: @toJSON!
        }

--- An embed field
-- @tparam string name The name of the field
-- @tparam string value The value of the field
-- @tparam[opt=false] boolean inline If the field is inline
-- @table field