
# Embeds and events

This tutorial assumes that you have followed part 1, [Simple bot](./02-embed-events.md)

## Embeds

So, there are 2 forms of embeds. This is the standard embed and the template embed. We are going to start with the normal embed.

Now we want to open our plugin we made.

```lua
-- plugin.lua
local harmonia = require 'Harmonia' -- Bring in our module

local plugin, Embed, lua = harmonia.Plugin, harmonia.Embed, harmonia.lua -- Import what we need

return lua.class('name', {}, plugin, function(self) -- Create our plugin
  self:super(self, 'new') -- Super it

  lua.class('example', { -- Create our command
    execute = function(_,msg, args) -- We drop first argument as its self
      local myEmbed = Embed() -- Create our embed
    end
  }, self.command, function(self) -- Our setup function
    self:super(self,'new')

    -- Command options
  end)
end)
```

The change we did is bringing in Embed and creating one. Now, embed takes an optional method.

This would be the initial state, usually you would do this with small embeds.

```lua
-- plugin.lua
-- ...
execute = function(_,msg, args) -- We drop first argument as its self
  local myEmbed = Embed({
    title = 'Fun embed'
  }) -- Create our embed
end
-- ...
```

We can't send this embed down to the channel like this.

```lua
msg:reply(myEmbed)
```

This is since Discordia will not read the embed data from the embed class. It does not understand what it is.

In order to make Discordia send this there are 2 ways.

```lua
-- Way 1

msg:reply(myEmbed:toJSON())

-- Way 2

myEmbed:send(msg.channel)
```

Way 2 is usually the better method as it runs checks. It checks if it can,

* Send messages
* Read messages
* Embed links

This makes it harder to get a 403 error. It still can happen like with dms but thats a given.

Now, lets look at the [docs for the embed](https://harmonia-project.github.io/Harmonia/classes/embed.html). We see there are quite a lot of methods.

All of these methods edit the look of the embed. Instead of setting title in the initial state we can do

```lua
local myEmbed = Embed()
myEmbed:setTitle('Fun embed')
```

Usually you want to use these set methods. This is since, like with sending, they have limits put into place.

* Titles are cut at 256 characters
* Descriptions are cut at 2048 characters
* Fields are limited to 25 fields
* Names of fields are cut at 256 characters
* Value of fields are cut as 1024 characters
* Footers are cut at 2048 characters
* Author names are cut at 256 characters

The only limit not followed is the 6000 character limit. This is since it would lower performance checking every since text field when editing text.

You can also chain methods as so

```lua
local myEmbed = Embed()
  :setColor(0x0099ff)
  :setTitle('Some title')
  :setURL('https://harmonia-project.github.io/Harmonia')
  :setAuthor('Some name', 'https://i.imgur.com/54BWIT5.png', 'https://harmonia-project.github.io/Harmonia')
  :setDescription('Some description here')
  :setThumbnail('https://harmonia-project.github.io/Harmonia')
  :addFields(
    {name = 'Regular field title', value = 'Some value here'},
    {name = 'Inline field title', value = 'Some value here', inline = true}
  )
  :addField('Inline field title', 'Some value here', true)
  :setImage('https://i.imgur.com/54BWIT5.png')
  :setTimestamp()
  :setFooter('Some footer text here', 'https://i.imgur.com/54BWIT5.png')

myEmbed:send(msg.channel)
```

This chaining allows for some neat syntactical sugar. This is very cool and stuff but we can step it up to another level.

### Templates

Now, you may ask, what is a template? A template is an embed in which we can use to either make more embeds or an embed itself.

You have 2 choices of template languages, [mustache](https://mustache.github.io/) and [etlua](https://github.com/leafo/etlua).

Here is an example of a mustache template

```lua
local level = Template { -- They extend embeds meaning that they allow for starting points
  title = '{{user}} just got to level {{level}}'
  description = '{{user}} got to level {{level}}! You now have {{coins}} coins!'
}

level:render({
  user = '4 times 1 is even less than 0#3870',
  level = 5,
  coins = '2'
}):send(channel)
```

This will fill in any of the {{template}} variables if they exist. In order to use etlua you need to pass the second variable as true.

```lua
local level = Template({
  title = '<%- fun %>'
}, true)

level:render({
  fun = 'yes'
}):send(channel)
```

These templates come in handy **A LOT** when it comes to prompts (Branched prompts). Next tutorial or so we will talk about prompts.

There is a time to use etlua vs mustache. If you don't have to use etlua, then don't use it. Etlua is a generally heavier renderer as it compiles the templates down to lua.

This makes it take more time than mustache which does not have to load any lua code whatsoever.

## Events

Now, how might we listen to events you may ask. Well its actually quite simple.

Lets go create a file named `reactionAdd.lua`. You should name your events what they are listening for. This is strictly not needed but it helps sort them out. We are going to do some organization in the next tutorial as well.

```lua
-- reactionAdd.lua
local harmonia = require 'Harmonia' -- Bring in our module
local lua = harmonia.lua -- The lua helper

lua.class('reactionAdd', {
    execute = function(channel, messageId, hash, userId)
      -- Do something
    end
  },
  event,
  function(self)
    self:super(self,'new')

    -- Options aka once
    self.once = false -- If this should be done only once
  end
)
```

Now, you may ask, how do we add it? Well its quite trivial. Its almost the same way you add a command.

```lua
-- main.lua
local harmonia = require 'Harmonia' -- Bring in our module

local client, dotenv = harmonia.Client, harmonia.dotenv -- Import what we need from the module

dotenv.config() -- Load our .env

local bot = client(process.env.TOKEN) -- Create a client

--bot:addCommand(require './command'()) -- Add the command to the bot

bot:addEvent(require './reactionAdd'()) -- Add the event to the bot

require './plugin':use(bot) -- Load the plugin

bot:login() -- Log into Discord
```

Something else we can do is put it into a plugin.

```lua
-- plugin.lua
local harmonia = require 'Harmonia' -- Bring in our module

local plugin, lua = harmonia.Plugin, harmonia.lua -- Import what we need

return lua.class('name', {}, plugin, function(self) -- Create our plugin
  self:super(self, 'new') -- Super it

  lua.class('example', { -- Create our command
    execute = function(_,msg, args) -- We drop first argument as its self
      msg:reply 'Some command'
    end
  }, self.command, function(self) -- Our setup function
    self:super(self,'new')

    -- Command options
  end)

  lua.class('reactionAdd', {
    execute = function(channel, messageId, hash, userId)
      -- Do something
    end
  }, self.event, function(self)
    self:super(self,'new')

    -- Options aka once
    self.once = false -- If this should be done only once
  end)
end)
```

And we can comment out the require on our event

```lua
-- main.lua
-- ...

-- bot:addEvent(require './reactionAdd'()) -- Add the event to the bot

-- ...
```

Now, next tutorial as I said will be some cleaning up and prompts.


