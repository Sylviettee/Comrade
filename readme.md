<div align="center">
  <h1>Comrade</h1>

  <a href="https://sovietkitsune.github.io/Comrade">Docs</a>
</div>

<div align="center">

  <img src="https://img.shields.io/travis/sovietkitsune/Comrade?style=flat">

  <img src="https://img.shields.io/discord/665029118575902739"/>

  <img src="https://img.shields.io/github/contributors/sovietkitsune/Comrade?style=flat">

  <div>Comrade is a safe, lightweight framework built using Moonscript</div>
</div>

## Features of Comrade

* Safe and easy embeds
* Robust command system
* Built in help system
* Unit testing support
* Unopinionated
* Moonscript support
* Lightweight
* Argument parsing system

## Bots using Comrade

If your bot uses Comrade send an issue with it.

* [Little Commander](https://github.com/SovietKitsune/Little-Commander)

## Example

```moon
import Command from require 'comrade'

class commandname extends Command
  new: =>
    super!

    @name = '' -- Override class name
    @aliases = {''}
    @permissions = {''} -- Uses overrides like if they have Moderation we can override them not having kick members
    @hidden = false -- It won't appear in help and can only be ran by an owner
    @allowDMS = false
    @cooldown = 3000 -- Comes in with a built in MS parser so it can say '3 minutes remaining' or '3 hours'

    @description = ''
    @usage = ''
    @example = ''
  
  subcommand: (msg, args, client) =>
    -- I only run when you say commandname subcommand
    msg\reply 'Subcommand!'

  execute: (msg, args, client) =>
    -- Command logic
    @help msg.channel -- Send the help message

commandname!
```

You can find more examples at the documentation

## Documentation

The documentation can be located at [https://sovietkitsune.github.io/Comrade](https://sovietkitsune.github.io/Comrade). 

If you have any issues you can join the support Discord [here](https://discord.gg/uCDq5mw) in the [#comrade](https://discordapp.com/channels/665029118575902739/738684991923290182/) channel.

## Installation

You can install it using `lit`. To install run

```sh
lit install SovietKitsune/Comrade
```

### Lightweight

The Comrade library takes up very little space already, being less than an mb.

## Credits

* Olivine Labs for [lustache](https://github.com/Olivine-Labs/lustache)
* Hisham Muhammad for [tabular](https://github.com/hishamhm/tabular)

## Todo

* [x] Examples be an array
* [x] Fixed preconditions
* [x] Check embed limits
* [x] Unload events and separation for plugin and commands
* [x] Examples for documentation
* [x] More advanced argument parsing system
* [ ] More test cases
* [ ] Pagination

## Scrapped

* Branched prompts Phased out by etlua prompts, check an example. [here](https://github.com/Roblox-Developers-CodeSkids/RobloxDevelopers/blob/master/commands/post.command.lua)
