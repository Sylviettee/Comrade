--- A module to parse a .env file
-- @module dotenv
dotenv = {}

import readFileSync from require 'fs'
import resolve from require 'path'

dotenv.split = (str, sep = '%s') ->
  t = {}

  for part in string.gmatch str, "([^#{sep}]+)"
    table.insert t, part
  t

dotenv.trim = (str) ->
  string.match str, '^%s*(.-)%s*$'

dotenv.transform = (str, quoted) ->
  switch str
    when 'false'
      (quoted and 'false') or false
    when 'true'
      (quoted and 'true') or true
    else
      (quoted and str) or (tonumber(str) and tonumber(str)) or str

--- Parses a .env file, does't support everything yet
-- @tparam string src The contents of the .env file
-- @tparam table options Contains if it is debug mode or not
-- @treturn table The parsed .env file
dotenv.parse = (src, options = {}) ->
  debug = options.debug
  obj = {}

  for idx, line in pairs dotenv.split src, '\n'
    key, val = line\match "%s*([^.%-]+)%s*=%s*(.*)%s*"

    unless key or val
      print "Failed to parse line #{idx} > #{line}" if debug
      continue
    
    isQuoted = val\sub(0,1) == '"' or val\sub(0,1) == "'" and val\sub(#val, #val) == '"' or val\sub(#val, #val) == "'"

    val = (isQuoted and val\sub 2, #val - 1) or val

    unless isQuoted
      val = dotenv.trim val
    
    obj[key] = dotenv.transform val, isQuoted

  obj

--- Automatically read, parse, and inject a .env file
-- @tparam table options The options on how to parse the file
-- @treturn table The parsed .env file
dotenv.config = (options = {}) ->
  dotenvPath = options.path or resolve process.cwd!, '.env'
  debug = options.debug or false

  return pcall () ->
    parsed = dotenv.parse readFileSync(dotenvPath), options

    for i,_ in pairs parsed
      if process.env[i]
        print "#{i} is already defined in process.env and will not be overwritten" if debug
        continue
      
      process.env[i] = parsed[i]

    return parsed

dotenv