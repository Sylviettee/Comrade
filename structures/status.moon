----
-- A command for testing to check the status of your tests
-- @classmod status

import request from require 'coro-http'
import parse from require 'json'

command = require './command'

tabular = require '../libs/tabular'

haste = 'https://hasteb.in/'

class status extends command
  --- Sets the usage, example, and description of the command
  new: () =>
    super!

    @usage = "#{@name}"
    @example = "#{@name}"
    @description = 'Shows status of tests'
    @hidden = true
  --- Get all status informaton
  execute: (msg,_,client) =>
    commands = {}

    client.commands\forEach (command) ->
      commands[command.name] = {
        errors: command.errors
        tested: command.tested
      }

    content = tabular({
      ['Cache']: {
        ['Guilds']: #client.guilds
        ['Users']: #client.users
        ['Dms']: #client.privateChannels
      }
      ['Commands']: commands
      ['Memory Usage']: "#{math.round((process.memoryUsage().heapUsed / 1024 / 1024) * 100) / 100} MB"
    })

    if #content < 1990
      msg\reply "```\n#{content}```"
    else
      _, res = request 'POST', "#{haste}documents", {
        {'Content-Type', 'text/plain'}
        {'Content-Length', #content}
      }, content

      body = parse res

      {:key} = body

      msg\reply "Content too large;\nPlease see: #{haste}#{key}.txt"

status!