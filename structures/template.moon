----
-- A template for creating embeds and more templates
-- @classmod Template

lustache = require '../libs/lustache'
etlua = require '../libs/etlua'
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
  --- Create a new template
  -- @tparam ?table start The starting point of the embed
  -- @tparam ?boolean useEtLua To use etlua as the renderer, mustache is the default renderer
  new: (start = {}, useEtLua = false) =>
    super start

    @usingEtLua = useEtLua

    if @usingEtLua
      @renderer = (...) => etlua.render ...
    else 
      @renderer = (...) => lustache\render ...

  --- Render the template into an embed
  -- @tparam ?table env The table to pass to the renderer
  render: (env = {}) =>
    tbl = deepScan @toJSON!, (val) ->
      @renderer val, env if type(val) == 'string'

    Embed tbl
  --- Render the template into another template
  -- @tparam ?table env The table to pass to the renderer
  -- @tparam ?boolean useEtLua To use etlua as the renderer, mustache is the default renderer
  construct: (env = {}, useEtLua = false) =>
    tbl = deepScan @toJSON!, (val) ->
      @renderer val, env if type(val) == 'string'
    
    Template tbl, useEtLua