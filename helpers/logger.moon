--- A module to make logging with colors easier
-- @module logger
logger = {}

import getenv from os

lustache = pcall require, "lustache"

unless lustache
  print 'Unable to find lustache, expect output to be messy'

  lustache = {
    render: (text) =>
      return text
  }

--- A table containing color bit values
-- @field 8 8 bit colors
-- @field 16 16 bit colors
-- @field 256 Some 256 bit colors
-- @table colors
logger.colors = {
  [8]: {
    black: '[30m'
    red: '[31m'
    green: '[32m'
    yellow: '[33m'
    blue: '[34m'
    magenta: '[35m'
    cyan: '[36m'
    white: '[37m'
    reset: '[0m'
  }
  [16]: {
    bright_black: '[30;1m'
    bright_red: '[31;1m'
    bright_green: '[32;1m'
    bright_yellow: '[33;1m'
    bright_blue: '[34;1m'
    bright_magenta: '[35;1m'
    bright_cyan: '[36;1m'
    bright_white: '[37;1m'
  }
  [256]: {
    link: '[4;38;5;14m'
    framed: '[51m'
  }
}

--- An internal table to store the current palette
logger.palette = {}

term = getenv "TERM"
color = getenv "COLORTERM"

theme = 8
truecolor = false

if term and (term == 'xterm' or term\find'-256color$')
  theme = 256
else
  theme = 8

truecolor = (color and (color == 'truecolor' or color == '24bit')) or false

for i,v in pairs logger.colors
  if i <= theme
    for color, code in pairs v
      logger.palette[color] = "\27#{code}"

if truecolor
  logger.palette.rgb = (text, render) ->
    render("\27[38;2;#{text\gsub ', ', ';'}m")

--- Renders text put in
-- @tparam string text The text to render with color
-- @tparam ?table env Some variables you can add to the renderer
-- @treturn string rendered The rendered text
logger.render = (text,env={}) ->
  palette = logger.palette

  for i,v in pairs env
    palette[i] =  v

  data = lustache\render text, palette

  data = data\gsub '&#x2F;', '/'

  data

logger