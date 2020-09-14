<div align="center">
  <h1>Comrade</h1>

  <a href="https://comrade-project.github.io/Comrade">Docs |</a>
  <a href="https://comrade-project.github.com/Comrade/blob/master/CHANGELOG.md">Changelog</a>
</div>

<div align="center">

  <img src="https://img.shields.io/discord/665029118575902739?logo=discord&label=Support&style=flat-square">

  <img src="https://img.shields.io/github/contributors/SovietKitsune/Comrade?label=Contributors&style=flat-square">

   <img src="https://img.shields.io/badge/Made%20with-MoonScript-ff69b4?style=flat-square">

  <div>Comrade is a light weight framework for Discordia and uses MoonScript.</div>
</div>

* [Bots using Comrade](#bots_using_comrade)
* [Features](#features)
* [Installation](#installation)
* [Todo](#todo)

## Bots using Comrade

If your bot uses Comrade send an issue with it.

* [Little Commander](https://github.com/SovietKitsune/Little-Commander)

## Documentation

The documentation can be located at [https://comrade-project.github.io/Comrade](https://comrade-project.github.io/Comrade). (Note that the search is non-functional for now)

If you have any issues you can join the support Discord [here](https://discord.gg/uCDq5mw) in the [#lua-comrade](https://discordapp.com/channels/665029118575902739/738684991923290182/) channel.

## Features

* ### Command system

  Comrades command system allows for subcommands, permissions, cooldowns, aliases in a snap. You can make a command owner only or accessible in dms with just changing 1 variable. You are not forced into using the default help. You can over ride it, if you want to over ride the help embed for a certain command then you can easily or for a group of commands.

* ### Hot reloading

  Comrade allows for you to load and unload commands with ease. If you combine a directory water like one found [here](https://github.com/Bilal2453/Commandia/blob/master/include/loader.lua) you can allow you to reload commands on save with ease. Make sure to check examples to see a simple way.

* ### Safety

  Comrade runs many checks before running a command. For example, if you want to run a command, it by defaults checks if the bot has permissions to speak in the channel. For embeds it checks if it has the ability to send messages and embed messages. Comrade comes with utilities like manageable since Discordia doesn't. This makes it harder for you to run into errors.

* ### Lightweight 

  Comrade only has 1 required dependency of Discordia which you should already have. The codebase for Comrade is also very small and very powerful.

## Installation

You can clone the repo into your deps folder or have it as a sub module

## Credits

* Olivine Labs for [lustache](https://github.com/Olivine-Labs/lustache)
* Hisham Muhammad for [tabular](https://github.com/hishamhm/tabular)

## Todo

- [x] Examples be an array
- [x] Fixed preconditions
- [x] Check embed limits
- [x] Unload events and separation for plugin and commands
- [x] Examples for documentation
- [ ] More test cases
- [ ] Pagination
- [ ] Branched prompts
- [ ] More advanced argument parsing system