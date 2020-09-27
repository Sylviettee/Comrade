import readdirSync, readFileSync from require 'fs'
import sleep from require 'timer'

Client = require '../structures/client'
Array = require '../structures/array'
Stack = require './stack'
Describe = require './framework'

logger = require './logger'

discordia = require 'discordia'

_class = discordia.class

faker, get = _class 'Faker Helper', Client -- A client to help test the main bot
-- Will pass the bot check

faker.__init = (token, config = {}) =>
  Client.__init @, token, config

  @_defaultChannel = config.channel
  @_mainbot = config.mainbot
  @_waitTime = config.waitTime or 10000
  @_sleepTime = config.sleepTime or 2500

  @_testStack = Stack!

  @\on 'ready', () ->
    if @_defaultChannel
      @_defaultChannel = @\getChannel @_defaultChannel

faker.deauth = =>
  current = @_mainbot.owners

  new = {}

  for _,v in pairs current
    table.insert new, v if v != @user.id

  @_mainbot\updateOwners new

faker.auth = =>
  current = table.clone @_mainbot.owners

  table.insert current, @user.id

  @_mainbot\updateOwners current

faker.send = (msg, channel) =>
  toSend = assert ((channel and @\getChannel channel) or @_defaultChannel), 'No channel found'

  toSend\send msg

faker.case = (test, fn) =>
  @_testStack\push {
    :test
    :fn
  }

faker.execute = (content, channel) =>
  @send content, channel

  didReply, reply = @\waitFor 'messageCreate', @_waitTime, (msg) ->
    msg.author.id == @_mainbot.user.id
  
  return didReply and reply or nil

faker.load = (dir) =>
  tests = Array(unpack readdirSync dir)\filter (file) ->
    file\match '.+%.spec%.lua$'

  tests\forEach (file) ->
    test = readFileSync "#{dir}/#{file}"

    sandbox = setmetatable {}, {
      __index: _G
    }

    sandbox.describe = (...) ->
      @_testStack\push Describe ...

    fn, syntax = load test, 'Test', 't', sandbox

    return logger.test file, syntax unless fn

    succ, err = pcall fn

    return logger.test file, err unless succ

faker.executeTests = =>
  current = coroutine.running!

  co = coroutine.create () ->
    @_testStack\forEach (test) ->
      pcall test.run, test, {
        bot: @_mainbot
        tester: @
        execute: (...) ->
          @execute ...
      }
      @_mainbot\resetErrors!
      @\resetErrors!

      sleep @_sleepTime, coroutine.running!

    coroutine.resume current
  
  coroutine.resume co
  coroutine.yield!

  logger.finish!

get.errored = =>
  #@_mainbot.errors > 0 or #@_errors > 0

get.channel = =>
  @_defaultChannel

faker