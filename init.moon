--- The root of all the modules
-- @module helper

succ, err = pcall require, 'discordia'

unless succ
  error "This module requires discordia!

#{err}"

require('./helpers/extensions') !

{
  -- Metadata

  --- The version
  version: '1.2.4'

  --- The name of the module
  name: 'Comrade'

  -- Classes

  --- @see Array
  Array: require './structures/array'

  --- @see Client
  Client: require './structures/client' 

  --- @see Command
  Command: require './structures/command'

  --- @see Embed
  Embed: require './structures/embed'

  --- @see Event
  Event: require './structures/event'

  --- @see Help
  Help: require './structures/help'

  --- @see LuaCommand
  LuaCommand: require './structures/luaCommand'

  --- @see Plugin
  Plugin: require './structures/plugin'

  --- @see Template
  Template: require './structures/template'

  --- @see Emitter
  Emitter: require './structures/emitter'

  --- @see Status
  Status: require './structures/status'

  -- Faker

  faker: require './faker'

  -- Helpers

  --- @see logger
  logger: require './helpers/logger'

  --- @see prompt
  prompt: require './helpers/prompt'

  --- @see util
  util: require './helpers/util'

  --- @see dotenv
  dotenv: require './helpers/dotenv'

  --- @see extensions
  extensions: require './helpers/extensions'

  --- @see color
  color: require './constants/color' --- color

  tabular: require './libs/tabular'

  lustache: require './libs/lustache'

  --- @see lua
  lua: require './lua' --- lua
}