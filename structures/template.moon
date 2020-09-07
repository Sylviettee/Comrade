lustache = require '../libs/'
Embed = require './Embed'

deepScan = (tbl, fn) ->
  for _,v in pairs tbl
    if type(v) == 'table'
      deepScan v, fn
    else
      fn v

class Template extends Embed
  new: (start) =>
    super start
  render: (env) =>
    deepScan @toJSON!, (val) ->
      lustache\render val, env if type(val) == 'string'