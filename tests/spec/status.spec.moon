describe 'status command', () ->
  it 'should display status information', () ->
    msg = assert execute "#{bot.prefix}status"
    content = msg.content

    unless content\find 'Content too large'
      assert content\find('Memory Usage'), 'No memory usage found'
      assert content\find('Commands'), 'No command information found'
      assert content\find('Cache'), 'No cache information found'
    
    assert not tester.errored, 'Bot errored while testing'
  it 'should not reply when unauthed', () ->
    tester\deauth! -- Revokes owner

    msg = execute "#{bot.prefix}status"
    assert not msg, 'Message was sent when there was an unauthed user'

    tester\auth!

    msg = execute "#{bot.prefix}status"
    assert msg, 'Message was not sent when there was an authed user'

    assert not tester.errored, 'Bot errored while testing'