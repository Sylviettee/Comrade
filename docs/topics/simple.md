
# Simple bot

> Comrade is a lightweight, safe framework built with MoonScript.

Today we are going to make a simple Discord bot with Comrade and Discordia.

## Setup

Before we can even start programming we need to get a bot token.

Go to [discord.com/developers](https://discord.com/developers) and create a new application by clicking the `New Application` button.

Give it a good name like `Fun Bot`. Now go navigate to the tab named `Bot` then click `Add Bot`. Make sure you confirm with `Yes, do it!`

Now you should see `TOKEN` and under it `Copy`. Click the copy button and write it down somewhere.

## Installation

### Luvit

You are going to need [Luvit](http://luvit.io/install.html).

Now you need to add it to your path.

#### On Windows

These are the steps to add Luvit (that is luvit, luvi, lit) to your system PATH on Windows. I recommend you follw this [general guide](https://bit.ly/2QfZ8Ii).

#### On Unix based systems

Lets say you installed it at ~/luvit/

You can just do in your shell. You can also put it in your `.profile`
```sh
export PATH="$HOME/luvit/:$PATH"
```

If you added it to your `.profile`
```sh
source ~/.profile
```

### Git

Another thing you are going to need is [git](https://git-scm.com/).

#### On Windows

If you use windows then you want to use [git bash](https://gitforwindows.org/)

Run it and install it. You can use this terminal instead of the command prompt.

#### On Unix based systems

If you are on a Unix based system then follow the instructions on the [download page](https://git-scm.com/download/linux)

### Comrade

Now you need to install Comrade. This is mostly done with a git submodule. You can also git clone it into a directory.

Make a new folder and open it in something like Visual Studio Code. If you are using Visual Studio Code you can press control + shift + `

This brings up the terminal, now with the terminal open you want to type `git init`. You want to now run `lit install SinisterRectus/discordia`. This installs discordia which Comrade depends on. Once that is done you can run `git submodule add https://github.com/comrade-project/Comrade.git deps/Comrade`. Now you should see some new files. These new files should be `.gitmodules` and a folder in deps called Comrade.

## Starting up

Now we can create a new file called `main.lua` and `.env`. Make sure that these files don't have `.txt` at the end or something.

In `.env` we have
```env
TOKEN=<Your bot token>
```
Make sure you replace `<Your bot token>` with your actual bot token we got from [setup](#setup)

In our `main.lua` we can have
```lua
local comrade = require 'Comrade' -- Bring in our module

local client, dotenv = comrade.Client, comrade.dotenv -- Import what we need from the module

dotenv.config() -- Load our .env

local bot = client(process.env.TOKEN) -- Create a client

bot:login() -- Log into Discord
```

If we run it we should get 2 files generated. A `discordia.log` and a `gateway.json`. Around about now we should create a `.gitignore`

This file prevents us from committing our private data.

```gitignore
*.log
*.env
gateway.json
```

In Visual Studio Code you should see these items go gray. This means that its ignored.

## First command

Now we want some functionality from this bot. We do with with a command.

```lua
-- command.lua
local comrade = require 'Comrade' -- Bring in our module

local command = comrade.LuaCommand -- The Lua helper

local comm = command 'example' -- Create a command named example

function comm:execute(msg) -- Create our executer function
  msg:reply 'Some command' -- When its called reply with Some command
end

return comm:make() -- Generate a readable command
```

A lot of it is boilerplate and all you really need is the execute function. If you want to know more about this you can check out the [Command](https://comrade-project.github.io/Comrade/classes/command.html) class.

Now in our `main.lua` we can import it.

```lua
-- main.lua
local comrade = require 'Comrade' -- Bring in our module

local client, dotenv = comrade.Client, comrade.dotenv -- Import what we need from the module

dotenv.config() -- Load our .env

local bot = client(process.env.TOKEN) -- Create a client

bot:addCommand(require './command'()) -- Add the command to the bot

bot:login() -- Log into Discord
```

Now we can go into a server with the bot. If we type `!help` we should see
```
example, help
```

Now run `!example` and you should see `Some command`.

If this all went to plan you have made your first command!

## Client options

You probably want to change the prefix and some other things.

This is done with a client config, here is some self explanatory code.

```lua
local bot = client(process.env.TOKEN, {
  prefix = '!', -- The prefix which the bot will respond to
  defaultHelp = true, -- To have the default help command loaded
  owners = {}, -- People who have complete control of the bot
  testing = false, -- If the bot is in testing mode or not
  testbot = false, -- If the current bot is a test bot
  botid = nil, -- The test bot id
  storeErrors = false, -- To store errors in a table
  disableDefaultCH = false, -- To disable the default command handler, mostly for custom prefixes
  -- Rest are from https://github.com/SinisterRectus/Discordia/wiki/Client-options
})
```

## First plugin

A plugin is a collection of events and commands. For example a plugin used in little commander is a welcoming plugin.

In lua, currently its not so pretty.

```lua
-- plugin.lua
local comrade = require 'Comrade' -- Bring in our module

local plugin, lua = comrade.Plugin, comrade.lua -- Import what we need

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
end)
```

Now in our `main.lua` we comment out the loading of our command. Plugins are loaded differently to commands. Instead of telling the client to load it, we tell the plugin to load it.

```lua
-- main.lua
local comrade = require 'Comrade' -- Bring in our module

local client, dotenv = comrade.Client, comrade.dotenv -- Import what we need from the module

dotenv.config() -- Load our .env

local bot = client(process.env.TOKEN) -- Create a client

--bot:addCommand(require './command'()) -- Add the command to the bot

require './plugin':use(bot) -- Load the plugin

bot:login() -- Log into Discord
```

Thats about it besides events. Next tutorial we will get more in depth with some of the classes.

## Resources

* [Comrade](https://comrade-project.github.io/Comrade/index.html)
* [Discordia](https://github.com/SinisterRectus/Discordia/wiki)
* [Luvit](http://luvit.io/api/)
* [Lua](https://www.lua.org/manual/5.1/)

