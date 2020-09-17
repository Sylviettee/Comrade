<div align="center">
  <h1>Comrade</h1>

  <a href="https://comrade-project.github.io/Comrade">Docs |</a>
  <a href="https://comrade-project.github.com/Comrade/blob/master/CHANGELOG.md">Changelog</a>
</div>

<div align="center">

  <img src="https://img.shields.io/travis/Comrade-project/Comrade?style=flat">

  <img src="https://img.shields.io/discord/665029118575902739"/>

  <img src="https://img.shields.io/github/contributors/Comrade-project/Comrade?style=flat">

  <div>Comrade is a safe, lightweight framework built using Moonscript</div>
</div>

## Features of Comrade

* Safe and easy embeds
* Robust command system
* Built in help system
* Unit testing support
* Unopinionated
* Moonscript support
* Lightweight and strippable

## Bots using Comrade

If your bot uses Comrade send an issue with it.

* [Little Commander](https://github.com/SovietKitsune/Little-Commander)

## Documentation

The documentation can be located at [https://comrade-project.github.io/Comrade](https://comrade-project.github.io/Comrade). (Note that the search is non-functional for now)

If you have any issues you can join the support Discord [here](https://discord.gg/uCDq5mw) in the [#lua-comrade](https://discordapp.com/channels/665029118575902739/738684991923290182/) channel.

## Installation

### Lightweight

The Comrade library takes up very little space already, being less than an mb.

However, if you feel as though thats too much you can do this to make your own lightweight version of Comrade.

```sh
git clone https://github.com/Comrade-project/Comrade.git # Or make a fork so its easy to transport

cd Comrade

rm -rf docs examples faker tests # Delete all unneeded folders

# If you don't need templates, logger, tabular, and status
# rm -rf libs
# rm ./structures/status.lua ./structures/template.lua ./helpers/logger.lua
# Edit init.lua to remove those requires

rm .gitignore .luacheckrc .luaformat.yaml .travis.yml CHANGELOG.md config.ld Makefile parse.lua readme.md # Delete all unneeded files

find . -name "*.moon" -type f -delete # Remove all source files

# Run your minifier

# If you made a fork
# git add .
# git commit -m "Minify"
# git push -u origin master
```

The size after this is less than 100K! (When this was written)

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