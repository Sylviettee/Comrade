import sort, concat, insert, remove from table
import min, max, random, ciel, floor from math
import byte, char, gmatch, match, rep, find, sub from string

table = {}

table.count = (tbl) ->
  n = 0

  for _ in pairs tbl
    n += 1
  n

table.deepcount = (tbl) ->
  ret = {}

  for k,v in pairs tbl
    ret[k] = type(v) == 'table' and table.deepcopy(v) or v
  
  return ret

table.reverse = (tbl) ->
  for i = 1, #tbl
    insert tbl, i, remove tbl

table.reversed = (tbl) ->
  ret = {}

  for i = #tbl, 1, -1
    insert ret, tbl[i]
  ret

table.keys = (tbl) ->
  ret = {}

  for k in pairs tbl
    insert ret, k
  ret

table.values = (tbl) ->
  ret = {}

  for _,v in pairs tbl
    insert ret, v
  ret

table.randomipair = (tbl) ->
  i = random #tbl
  return i, tbl[i]

table.randompair = (tbl) ->
  rand = random table.count tbl
  n = 0

  for k,v in pairs tbl
    n += 1
    if n == rand
      return k,v

table.sorted = (tbl, fn) ->
  ret = {}

  for i,v in ipairs tbl
    ret[i] = v
  
  sort ret, fn
  ret

table.search = (tbl, value) ->
  for k,v in pairs tbl
    if v == value
      return k

  return nil

table.slice = (tbl, start, stop, step) ->
  ret = {}

  for i = start or 1, stop or #tbl, step or 1
    insert ret, tbl[i]
  
  ret

table.join = (tbl, sep) ->
  str = ''
  for _,v in pairs tbl
    if type(v) != 'table'
      str ..= v .. sep
  
  str

string = {}

string.split = (str, delim) ->
  ret = {}
  return ret unless str

  if not delim or delim == ''
    for c in gmatch str, '.'
      insert ret, c

    return ret
  
  n = 1

  while true
    i, j = find str, delim, n
    break unless i

    insert ret, sub str, n, i - 1
    n = j + 1
  
  insert ret, sub str, n

  ret

string.trim = (str) ->
  return match str, '^%s*(.-)%s*$'

string.startswith = (str, start) ->
  str\sub(1, #start) == start

string.endswith = (str, End) ->
  str\sub(#str - #End + 1, #str) == End

string.random = (len, mn = 0, mx = 255) ->
  ret = {}

  for _ = 1, len
    insert ret, char random mn, mx
  
  concat ret

string.clamp = (n, mn, mx) ->
  min max(n, mn), mx

ext = setmetatable {
  table: table
  string: string
  math: math
}, {
  __call: () =>
    for _, v in pairs @
      v!
}

for n, m in pairs(ext) do
  setmetatable m, {
    __call: () =>
      for k, v in pairs @
        _G[n][k] = v
  }

return setmetatable {}, {
  __call: () =>
    ext.string!
    ext.math!
    ext.table!
}