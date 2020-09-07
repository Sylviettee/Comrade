import Template, Embed from require 'comrade'

-- Normal embeds --

embed = Embed {
  title: 'You just got level 0'
  description: 'You just got level 0! You now have 5 coins!'
}

embed = Embed!\setTitle('You just got level 0')\setDescription 'You just got level 0! You now have 5 coins!' -- Other method

-- Templates --

-- Under the hood they use handlebars to handle the rendering

level = Template { -- They extend embeds meaning that they allow for starting points
  title: '{{user}} just got to level {{level}}'
  description: '{{user}} got to level {{level}}! You now have {{coins}} coins!'
}

level\compile {
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

leaderboard\compile {
  members: { 
    {name: 'Github Issues', level: 100}
    {name: '4 times 1 is even less than 0', level: 5}
  }
}