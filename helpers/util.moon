--- A utility module for time, moderation, and permissions
-- @module util
import permission from require('discordia').enums
enums = permission
util = {}

roles = {
  administrator: {
    'administrator'
  },
  moderator: {
    'kickMembers',
    'banMembers',
    'manageMessages',
    'manageNicknames',
    'mentionEveryone'
  },
  ['bot manager']: {
    'manageGuild',
    'manageRoles'
  }
}

-- Time

s = 1000
m = s * 60
h = m * 60
d = h * 24
w = d * 7
y = d * 365.25

--- Convert years into milliseconds
-- @tparam number years
-- @treturn number milliseconds
util.years = (years) ->
  years * y

--- Convert weeks into milliseconds
-- @tparam number weeks
-- @treturn number milliseconds
util.weeks = (weeks) ->
  weeks * w

--- Convert days into milliseconds
-- @tparam number days
-- @treturn number milliseconds
util.days = (days) ->
  days * d

--- Convert hours into milliseconds
-- @tparam number hours
-- @treturn number milliseconds
util.hours = (hours) ->
  hours * h

--- Convert minutes into milliseconds
-- @tparam number minutes
-- @treturn number milliseconds
util.minutes = (minutes) ->
  minutes * m

--- Convert seconds into milliseconds
-- @tparam number seconds
-- @treturn number milliseconds
util.seconds = (seconds) ->
  seconds * s

--- Convert milliseconds into a long formatted time; eg 10 days
-- @tparam number milliseconds
-- @treturn string formatted
util.formatLong = (milliseconds) ->
  msAbs = math.abs milliseconds

  if msAbs >= d
    return util.plural milliseconds, msAbs, d, 'day'
  if msAbs >= h
    return util.plural milliseconds, msAbs, h, 'hour'
  if msAbs >= m
    return util.plural milliseconds, msAbs, m, 'minute'
  if msAbs >= s
    return util.plural milliseconds, msAbs, s, 'second'
  
  return "#{milliseconds} ms"

--- Check if a time should be plural
-- @tparam number ms
-- @tparam number msAbs Absolute value of the milliseconds
-- @tparam number n The amount of milliseconds in the unit
-- @tparam string name The name of the unit eg `second` 
-- @treturn string Name with possibly an s
util.plural = (ms,msAbs, n, name) ->
  isPlural = (msAbs >= n * 1.5)

  return "#{math.floor (ms / n) + 0.5} #{name}#{(isPlural and 's') or ''}"

--- Bulk delete messages in a channel using getMessages
-- @param msg The message you got the call to bulk delete
-- @tparam table|number messages
-- @treturn {table,...} The messages that were deleted
util.bulkDelete = (msg,messages) ->
  if type(messages) == 'table' then
    messageIDs = {}

    for _,m in pairs messages
      table.insert messageIDs, m.id or m

    if #messageIDs == 0 
      return {}
    if #messageIDs == 1
      msg.channel\getMessage(messageIDs[1])\delete!
      return {messageIDs[1]}

    msg.channel\bulkDelete messageIDs

    messageIDs
  elseif type(messages) == 'number'
    util.bulkDelete msg, msg.channel\getMessages messages

--- Compare 2 roles positions
-- @param role1 The first role to compare
-- @param role2 The second role to compare
-- @treturn number The distance from first role to second
util.compareRoles = (role1,role2) ->
  if role1.position == role2.position 
    return role2.id - role1.id
  role1.position - role2.position

--- Compare 2 roles positions
-- @param member The member to see if the bot can manage
-- @treturn boolean If true, the bot can manage the member, else than not
util.manageable = (member) ->
  if member.user.id == member.guild.ownerId
    return false
  if member.user.id == member.client.user.id
    return false
  if member.client.user.id == member.guild.ownerId
    return true
  util.compareRoles(member.guild.me.highestRole, member.highestRole) > 0

--- Check if the member has permissions or a role override
-- @param member The member to check the permissions of
-- @param channel The channel that the member is using
-- @tparam table permissions The permissions you want to check, eg kickMembers
util.checkPerm = (member,channel,permissions) ->
  unless type(permissions) == 'table'
    permissions = {permissions}
  if #permissions == 0
    return true
  
  hasRole = (member,role) ->
    has = nil
    member.roles\forEach (role) ->
      if role.name\lower! == role\lower!
        has = true
    has

  -- If no member then they can't have perms
  
  return false unless member

  perms = member\getPermissions channel

  permCodes = {}

  for _,perm in pairs permissions
    table.insert permCodes, enums[perm]

  if perms\has unpack permCodes
    return true
  else
    if hasRole member, 'administrator'
      return true
    else
      needed = {}

      for roleName, perms in pairs roles
        for _, perm in pairs perms
          if table.search perm, permissions
            table.insert needed, roleName
      
      has = true
      
      if #needed > 0
        for _,role in pairs needed
          unless hasRole member, role
            has = false
        
        return has
      else
        return false

util