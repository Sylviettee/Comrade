import Template, Embed from require 'Harmonia'

-- Normal embeds --

embed = Embed {
  title: 'You just got level 0'
  description: 'You just got level 0! You now have 5 coins!'
}

embed\send 'channel'

embed = Embed!\setTitle('You just got level 0')\setDescription 'You just got level 0! You now have 5 coins!' -- Other method

embed\send 'channel'

-- Templates --

-- Under the hood they use handlebars to handle the rendering

level = Template { -- They extend embeds meaning that they allow for starting points
  title: '{{user}} just got to level {{level}}'
  description: '{{user}} got to level {{level}}! You now have {{coins}} coins!'
}

level\render {
  user: '4 times 1 is even less than 0#3870', 
  level: 5, 
  coins: '2'
}

-- Since they use handlebars

leaderboard = Template {
  title: "{{guild}}'s leaderboard'"
  description: '
{{#members}}
{{name}} - {{level}}
{{/members}}
'
}

leaderboard\render {
  members: { 
    {name: 'Github Issues', level: 100}
    {name: '4 times 1 is even less than 0', level: 5}
  }
}