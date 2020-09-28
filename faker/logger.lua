local logger = require('../helpers/logger')
local log = {}
log.ran = 0
log.fails = 0
log.start = os.time()
log.case = function(name) return logger.render(tostring(name) .. '{{reset}} ->') end
log.test = function(name, err)
  log.ran = log.ran + 1
  if err then log.fails = log.fails + 1 end
  return logger.render('  {{' .. tostring(err and 'red' or 'green') .. '}}' .. tostring(name) .. '{{reset}} -> ' ..
                           tostring(err and 'failed' or 'passed') .. tostring(err and '\n    ' .. tostring(err) or ''))
end
log.finish = function()
  return print(logger.render('\n---------------------\n{{green}}' .. tostring(log.ran - log.fails) ..
                                 '{{reset}} passed \n{{red}}' .. tostring(log.fails) .. '{{reset}} failed\n{{white}}' ..
                                 tostring(os.time() - log.start) .. '{{reset}} seconds'))
end
return log
