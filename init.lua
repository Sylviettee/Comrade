local succ, err = pcall(require, 'discordia')
if not (succ) then
  error("This module requires discordia!\n\n" .. tostring(err))
end
require('./helpers/extensions')()
return {
  version = '1.2.1',
  name = 'Comrade',
  Array = require('./structures/array'),
  Client = require('./structures/client'),
  Command = require('./structures/command'),
  Embed = require('./structures/embed'),
  Event = require('./structures/event'),
  Help = require('./structures/help'),
  LuaCommand = require('./structures/luaCommand'),
  Plugin = require('./structures/plugin'),
  Template = require('./structures/template'),
  Emitter = require('./structures/emitter'),
  faker = require('./faker'),
  logger = require('./helpers/logger'),
  prompt = require('./helpers/prompt'),
  util = require('./helpers/util'),
  dotenv = require('./helpers/dotenv'),
  extensions = require('./helpers/extensions'),
  color = require('./constants/color'),
  tabular = require('./libs/tabular'),
  lustache = require('./libs/lustache'),
  lua = require('./lua')
}
