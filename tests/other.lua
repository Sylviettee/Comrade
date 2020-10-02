local Client, dotenv
do
  local _obj_0 = require('../init')
  Client, dotenv = _obj_0.Client, _obj_0.dotenv
end
if not (process.env.TOKEN) then dotenv.config() end
local bot = Client(process.env.TOKEN, {prefix = '='})
bot:addCommand(require('./advanced')())
return bot:login()
