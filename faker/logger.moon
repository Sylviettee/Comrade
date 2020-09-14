logger = require '../helpers/logger'

log = {}

log.ran = 0
log.fails = 0
log.start = os.time!

log.case = (name) ->
  logger.render "#{name}{{reset}} ->"

log.test = (name, err) ->
  log.ran += 1

  log.fails += 1 if err

  logger.render "  {{#{err and 'red' or 'green'}}}#{name}{{reset}} -> #{err and 'failed' or 'passed'}#{err and '\n    ' .. tostring(err) or ''}"

log.finish = () ->
  print logger.render "
---------------------
{{green}}#{log.ran - log.fails}{{reset}} passed 
{{red}}#{log.fails}{{reset}} failed
{{white}}#{os.time! - log.start}{{reset}} seconds"

log