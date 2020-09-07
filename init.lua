local succ, err = pcall(require, 'discordia')
if not (succ) then
  error('This module requires discordia!')
end
return {
  version = '1.0.0-dev',
  name = 'Comrade',
  Array = require('./structures/array'),
  Client = require('./structures/client'),
  Command = require('./structures/command'),
  Embed = require('./structures/embed'),
  Event = require('./structures/event'),
  Help = require('./structures/help'),
  InternalError = require('./structures/internalError'),
  LuaCommand = require('./structures/luaCommand'),
  Plugin = require('./structures/plugin'),
  logger = require('./helpers/logger'),
  prompt = require('./helpers/prompt'),
  util = require('./helpers/util'),
  dotenv = require('./helpers/dotenv'),
  extenstions = require('./helpers/extenstions'),
  color = require('./constants/color'),
  lua = require('./lua')
}
