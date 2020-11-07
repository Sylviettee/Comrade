local permission
do
  local _obj_0 = require('discordia').enums
  permission = _obj_0.permission
end
local enums = permission
local util = {}
local roles = {
  administrator = {'administrator'},
  moderator = {'kickMembers', 'banMembers', 'manageMessages', 'manageNicknames', 'mentionEveryone'},
  ['bot manager'] = {'manageGuild', 'manageRoles'}
}
local s = 1000
local m = s * 60
local h = m * 60
local d = h * 24
local w = d * 7
local y = d * 365.25
util.years = function(years) return years * y end
util.weeks = function(weeks) return weeks * w end
util.days = function(days) return days * d end
util.hours = function(hours) return hours * h end
util.minutes = function(minutes) return minutes * m end
util.seconds = function(seconds) return seconds * s end
util.formatLong = function(milliseconds)
  local msAbs = math.abs(milliseconds)
  if msAbs >= d then return util.plural(milliseconds, msAbs, d, 'day') end
  if msAbs >= h then return util.plural(milliseconds, msAbs, h, 'hour') end
  if msAbs >= m then return util.plural(milliseconds, msAbs, m, 'minute') end
  if msAbs >= s then return util.plural(milliseconds, msAbs, s, 'second') end
  return tostring(milliseconds) .. ' ms'
end
util.plural = function(ms, msAbs, n, name)
  local isPlural = (msAbs >= n * 1.5)
  return tostring(math.floor((ms / n) + 0.5)) .. ' ' .. tostring(name) .. tostring((isPlural and 's') or '')
end
util.bulkDelete = function(msg, messages)
  if type(messages) == 'table' then
    local messageIDs = {}
    for _, m in pairs(messages) do table.insert(messageIDs, m.id or m) end
    if #messageIDs == 0 then return {} end
    if #messageIDs == 1 then
      msg.channel:getMessage(messageIDs[1]):delete()
      return {messageIDs[1]}
    end
    msg.channel:bulkDelete(messageIDs)
    return messageIDs
  elseif type(messages) == 'number' then
    return util.bulkDelete(msg, msg.channel:getMessages(messages))
  end
end
util.compareRoles = function(role1, role2)
  if role1.position == role2.position then return role2.id - role1.id end
  return role1.position - role2.position
end
util.manageable = function(member)
  if member.user.id == member.guild.ownerId then return false end
  if member.user.id == member.client.user.id then return false end
  if member.client.user.id == member.guild.ownerId then return true end
  return util.compareRoles(member.guild.me.highestRole, member.highestRole) > 0
end
util.checkPerm = function(member, channel, permissions)
  if not (type(permissions) == 'table') then permissions = {permissions} end
  if #permissions == 0 then return true end
  local hasRole
  hasRole = function(member, role)
    local has = nil
    member.roles:forEach(function(role) if role.name:lower() == role:lower() then has = true end end)
    return has
  end
  if not member then return false end
  local perms = member:getPermissions(channel)
  local permCodes = {}
  for _, perm in pairs(permissions) do table.insert(permCodes, enums[perm]) end
  if perms:has(unpack(permCodes)) then
    return true
  else
    if hasRole(member, 'administrator') then
      return true
    else
      local needed = {}
      for roleName, perms in pairs(roles) do
        for _, perm in pairs(perms) do if table.search(perm, permissions) then table.insert(needed, roleName) end end
      end
      local has = true
      if #needed > 0 then
        for _, role in pairs(needed) do if not hasRole(member, role) then has = false end end
        return has
      else
        return false
      end
    end
  end
end
return util
