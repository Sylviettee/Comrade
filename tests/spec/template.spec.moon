describe 'template class', () ->
  import Template from depend '../init'

  it 'should render a template', () ->
    level = Template { -- They extend embeds meaning that they allow for starting points
      title: '{{user}} just got to level {{level}}'
      description: '{{user}} got to level {{level}}! You now have {{coins}} coins!'
    }

    embed = level\render {
      user: '4 times 1 is even less than 0#3870', 
      level: 5, 
      coins: '2'
    }

    raw = embed\toJSON!

    assert raw.title == '4 times 1 is even less than 0#3870 just got to level 5', 'Title does not match'

    assert raw.description == '4 times 1 is even less than 0#3870 got to level 5! You now have 2 coins!', 'Description does not match'

    assert embed\send(tester.channel), 'Failed to send'

    assert not tester.errored, 'Bot errored while testing'
  
  it 'should allow full use of handlebars', () ->
    leaderboard = Template {
      title: "{{guild}}'s leaderboard"
      description: '
    {{#members}}
    {{name}} - {{level}}
    {{/members}}
    '
    }

    embed = leaderboard\render {
      guild: 'Our Cult'
      members: { 
        {name: 'Github Issues', level: 100}
        {name: '4 times 1 is even less than 0', level: 5}
      }
    }

    assert embed\send(tester.channel), 'Failed to send'

    assert not tester.errored, 'Bot errored while testing'
  
  it 'should render fields', () ->
    fields = Template {
      title: 'Fun'
    }

    for i = 1, 5
      fields\addField "{{name}}#{i}", "{{bio}}"
    
    embed = fields\render {
      name: 'Soviet'
      bio: 'Pro bug creator'
    }

    sent = assert embed\send(tester.channel), 'Failed to send'

    fields = {}

    for _,v in pairs sent.embeds[1].fields
      fields[v.name] = v.value\trim!
    
    assert fields.Soviet1 == 'Pro bug creator', 'Failed to render a field'

    assert not tester.errored, 'Bot errored while testing'