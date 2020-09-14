describe 'help command', () ->
  it 'should display commands', () ->
    msg = assert execute "#{bot.prefix}help"

    help = msg.embeds[1]

    assert help.title == 'Help', "Help title not 'Help'"
    
    desc = ''

    bot.commands\forEach (command) ->
      desc = "#{desc}, `#{command.name}`"

    desc = desc\sub(2,#desc)

    assert desc\trim! == help.description, "Help description does not match '#{desc\trim!}'"

    assert not tester.errored, 'Bot errored while testing'
  it 'should give information about a command', () ->
    msg = assert execute "#{bot.prefix}help help"

    help = bot.commands\find (command) ->
      command.name == 'help'
    
    embed = msg.embeds[1]

    assert embed.title == 'Help', "Help title not 'Help'"

    fields = {}

    for _,v in pairs embed.fields
      fields[v.name] = v.value\trim!

    assert fields.Description == help.description\trim!, 'Help description not same'
    assert fields.Usage == help.usage\trim!, 'Usages are not the same'
    assert fields.Example == help.formatted\trim!, 'Examples are not the same'

    assert fields.Aliases == (
        (table.concat(help.aliases, ', ') == '' and 'None') or 
        (table.concat(help.aliases, ', ') != '' and table.concat(help.aliases, ', '))
      )\trim!, 
      'Help aliases are not the same'
    
    assert fields.Subcommands == (
        (table.concatIndex(help.subcommands, ', ') == '' and 'None') or 
        (table.concatIndex(help.subcommands, ', ') != '' and table.concatIndex(help.subcommands, ', '))
      )\trim!,
      'Help subcommands are not the same'
    
    assert not tester.errored, 'Bot errored while testing'