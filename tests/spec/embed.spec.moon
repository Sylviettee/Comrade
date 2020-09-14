describe 'embed class', () ->
  import Embed from depend '../init'

  char = (count) ->
    str = ''
    for i = 1, count
      str = str .. 'a'
    str

  it 'should be able to send embeds', () ->
    assert Embed({
      title: 'hi'
    })\send(tester.channel), 'No embed was sent'

    assert not tester.errored, 'Bot errored while testing'
  it 'should prevent more than 25 fields', () ->
    embed = Embed!

    for i = 0, 30
      embed\addField "T: #{i}", "V: #{i}"

    assert embed\send(tester.channel), 'Failed to send'

    assert not tester.errored, 'Bot errored while testing'
  it 'should prevent more than 256 characters in the title', () ->
    embed = Embed!
    
    embed\setTitle char 300

    assert embed\send(tester.channel), 'No embed was sent'

    assert not tester.errored, 'Bot errored while testing'
  it 'should prevent more than 2048 characters in the description', () ->
    embed = Embed!
    
    embed\setDescription char 3000

    assert embed\send(tester.channel), 'No embed was sent'

    assert not tester.errored, 'Bot errored while testing'
  it 'should prevent more than 2048 characters in the footer', () ->
    embed = Embed!
    
    embed\setFooter char 3000

    assert embed\send(tester.channel), 'No embed was sent'

    assert not tester.errored, 'Bot errored while testing'
  it 'should prevent more than 256 characters in the author', () ->
    embed = Embed!
    
    embed\setAuthor char 300

    assert embed\send(tester.channel), 'No embed was sent'

    assert not tester.errored, 'Bot errored while testing'
  it 'should prevent more than 256 characters in the field title', () ->
    embed = Embed!

    embed\addField char(300), "E"

    assert embed\send(tester.channel), 'Failed to send'

    assert not tester.errored, 'Bot errored while testing'
  it 'should prevent more than 1024 characters in the field value', () ->
    embed = Embed!

    embed\addField 'E', char 2000

    assert embed\send(tester.channel), 'Failed to send'

    assert not tester.errored, 'Bot errored while testing'