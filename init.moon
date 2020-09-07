--- The root of all the modules
-- @module helper

succ, err = pcall require, 'discordia'

unless succ
  error 'This module requires discordia!'

{
  -- Metadata

  --- The version
  version: '1.0.0-dev'

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

  --- @see InternalError
  InternalError: require './structures/internalError'

  --- @see LuaCommand
  LuaCommand: require './structures/luaCommand'

  --- @see Plugin
  Plugin: require './structures/plugin'

  -- Helpers

  --- @see logger
  logger: require './helpers/logger'

  --- @see prompt
  prompt: require './helpers/prompt'

  --- @see util
  util: require './helpers/util'

  --- @see dotenv
  dotenv: require './helpers/dotenv'

  --- @see extenstions
  extenstions: require './helpers/extenstions'

  --- @see color
  color: require './constants/color' --- color

  --- @see lua
  lua: require './lua' --- lua

}