import readFileSync, existsSync, writeFileSync from require 'fs'
import exec from require 'childprocess'

file = process.argv[2] or 'config.lua'
torun = process.argv[3] or error 'You need to specify a set to run!'

runset = (set, pos = 1, finished = () -> return) ->
  current = set[pos]

  unless current == ''
    child = exec current, (_, _, ...) ->
      print ...

    child\on 'exit', () ->
      if #set > pos
        runset set, pos + 1 
      else
        finished!
  else
    if #set > pos
      runset set, pos + 1 if #set > pos
    else
      finished!

if existsSync file
  code = readFileSync file

  unless code\sub(0, 6) == 'return'
    code = 'return ' .. code
  
  env = setmetatable {}, {
    __index: _G
  }

  fn, syntax = load code, "make:#{file}", 't', env

  return error syntax unless fn

  instructions = fn!

  if torun == 'make'
    makefile = "# Automatically generated from #{file}\n\n"

    if instructions.default
      makefile ..= ".DEFAULT_GOAL := #{instructions.default}\n\n"
    
    for i,v in pairs instructions
      if i != 'default'
        makefile ..= "#{i}:
\t@echo -e '\\033[32mRunning #{i}\\033[0m'
\t@#{(#v > 1 and 'luvit parse.lua config.lua ' .. i) or v[1]}
"
    
    writeFileSync 'Makefile', makefile
  else
    runset instructions[torun]
