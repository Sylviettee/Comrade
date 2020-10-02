local Template, Embed
do
  local _obj_0 = require('comrade')
  Template, Embed = _obj_0.Template, _obj_0.Embed
end
local embed = Embed({title = 'You just got level 0', description = 'You just got level 0! You now have 5 coins!'})
embed:send('channel')
embed = Embed():setTitle('You just got level 0'):setDescription('You just got level 0! You now have 5 coins!')
embed:send('channel')
local level = Template({
  title = '{{user}} just got to level {{level}}',
  description = '{{user}} got to level {{level}}! You now have {{coins}} coins!'
})
level:render({user = '4 times 1 is even less than 0#3870', level = 5, coins = '2'})
local leaderboard = Template({
  title = '{{guild}}\'s leaderboard\'',
  description = '\n{{#members}}\n{{name}} - {{level}}\n{{/members}}\n'
})
return leaderboard:render({
  members = {{name = 'Github Issues', level = 100}, {name = '4 times 1 is even less than 0', level = 5}}
})
