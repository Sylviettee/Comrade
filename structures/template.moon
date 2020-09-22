lustache = require '../libs/lustache'
Embed = require './embed'

deepScan = (tbl, fn) ->
  clone = table.clone tbl

  for i,v in pairs clone
    if type(v) == 'table'
      clone[i] = deepScan v, fn
    else
      clone[i] = fn v

  clone

class Template extends Embed
  new: (start) =>
    super start
  render: (env) =>
    tbl = deepScan @toJSON!, (val) ->
      lustache\render val, env if type(val) == 'string'

    Embed tbl
  construct: (env) =>
    tbl = deepScan @toJSON!, (val) ->
      lustache\render val, env if type(val) == 'string'
    
    Template tbl