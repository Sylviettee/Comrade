logger = require './logger'

class It
  new: (parent, name, fn) =>
    @parent = parent
    @name = name
    @fn = fn
  run: (env = {}) =>
    funcEnv = getfenv @fn

    for i,v in pairs env
      funcEnv[i] = v
    
    succ, err = pcall @fn

    logger.test @name, not succ and err

class Describe
  new: (test, fn) =>
    @name = test

    @cases = {}
    @out = {}
    @canLoad = true

    env = getfenv fn

    env.it = (name, fn) ->
      table.insert @cases, It @, name, fn
    
    env.depend = (name) ->
      require name

    succ, err = pcall fn

    @canLoad = succ

    table.insert @out, logger.case test

    unless @canLoad
      table.insert @out, logger.test 'Load tests', err

  run: (env = {}) =>
    return unless @canLoad

    for _,v in pairs @cases
      table.insert @out, v\run env

      collectgarbage "collect"
    
    print table.concat @out, '\n'

return Describe