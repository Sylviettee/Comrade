local readFileSync, existsSync, writeFileSync
do
  local _obj_0 = require('fs')
  readFileSync, existsSync, writeFileSync = _obj_0.readFileSync, _obj_0.existsSync, _obj_0.writeFileSync
end
local exec
exec = require('childprocess').exec
local file = process.argv[2] or 'config.lua'
local torun = process.argv[3] or error('You need to specify a set to run!')
local runset
runset = function(set, pos, finished)
  if pos == nil then
    pos = 1
  end
  if finished == nil then
    finished = function() end
  end
  local current = set[pos]
  if not (current == '') then
    local child = exec(current, function(_, _, ...)
      return print(...)
    end)
    return child:on('exit', function()
      if #set > pos then
        return runset(set, pos + 1)
      else
        return finished()
      end
    end)
  else
    if #set > pos then
      if #set > pos then
        return runset(set, pos + 1)
      end
    else
      return finished()
    end
  end
end
if existsSync(file) then
  local code = readFileSync(file)
  if not (code:sub(0, 6) == 'return') then
    code = 'return ' .. code
  end
  local env = setmetatable({ }, {
    __index = _G
  })
  local fn, syntax = load(code, "make:" .. tostring(file), 't', env)
  if not (fn) then
    return error(syntax)
  end
  local instructions = fn()
  if torun == 'make' then
    local makefile = "# Automatically generated from " .. tostring(file) .. "\n\n"
    if instructions.default then
      makefile = makefile .. ".DEFAULT_GOAL := " .. tostring(instructions.default) .. "\n\n"
    end
    for i, v in pairs(instructions) do
      if i ~= 'default' then
        makefile = makefile .. tostring(i) .. ":\n\t@echo -e '\\033[32mRunning " .. tostring(i) .. "\\033[0m'\n\t@" .. tostring((#v > 1 and 'luvit parse.lua config.lua ' .. i) or v[1]) .. "\n"
      end
    end
    return writeFileSync('Makefile', makefile)
  else
    return runset(instructions[torun])
  end
end
