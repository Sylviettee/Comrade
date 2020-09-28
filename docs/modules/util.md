
# Module `util`
A utility module for time, moderation, and permissions









### [Functions](#Functions)
| Property | Description |
| -------- | ----------- |
| years (years) | Convert years into milliseconds |
| weeks (weeks) | Convert weeks into milliseconds |
| days (days) | Convert days into milliseconds |
| hours (hours) | Convert hours into milliseconds |
| minutes (minutes) | Convert minutes into milliseconds |
| seconds (seconds) | Convert seconds into milliseconds |
| formatLong (milliseconds) | Convert milliseconds into a long formatted time; eg 10 days |
| plural (ms, msAbs, n, name) | Check if a time should be plural |
| bulkDelete (msg, messages) | Bulk delete messages in a channel using getMessages |
| compareRoles (role1, role2) | Compare 2 roles positions |
| manageable (member) | Compare 2 roles positions |
| checkPerm (member, channel, permissions) | Check if the member has permissions or a role override |



## [Functions](#Functions)

### [years (years)](#years)
Convert years into milliseconds



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| years | <span class="type">number</span> | ❌ | `none` |

 |





**Returns:** <span class="type">number</span> millisecon










### [weeks (weeks)](#weeks)
Convert weeks into milliseconds



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| weeks | <span class="type">number</span> | ❌ | `none` |

 |





**Returns:** <span class="type">number</span> millisecon










### [days (days)](#days)
Convert days into milliseconds



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| days | <span class="type">number</span> | ❌ | `none` |

 |





**Returns:** <span class="type">number</span> millisecon










### [hours (hours)](#hours)
Convert hours into milliseconds



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| hours | <span class="type">number</span> | ❌ | `none` |

 |





**Returns:** <span class="type">number</span> millisecon










### [minutes (minutes)](#minutes)
Convert minutes into milliseconds



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| minutes | <span class="type">number</span> | ❌ | `none` |

 |





**Returns:** <span class="type">number</span> millisecon










### [seconds (seconds)](#seconds)
Convert seconds into milliseconds



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| seconds | <span class="type">number</span> | ❌ | `none` |

 |





**Returns:** <span class="type">number</span> millisecon










### [formatLong (milliseconds)](#formatLong)
Convert milliseconds into a long formatted time; eg 10 days



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| milliseconds | <span class="type">number</span> | ❌ | `none` |

 |





**Returns:** <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> formatt










### [plural (ms, msAbs, n, name)](#plural)
Check if a time should be plural



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| ms | <span class="type">number</span> | ❌ | `none` |

 |
| msAbs | <span class="type">number</span> | ❌ | `none` |  Absolute value of the milliseconds |
| n | <span class="type">number</span> | ❌ | `none` |  The amount of milliseconds in the unit |
| name | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The name of the unit eg <code>second</code> |





**Returns:** <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> Name with possibly an










### [bulkDelete (msg, messages)](#bulkDelete)
Bulk delete messages in a channel using getMessages



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| msg |  | ❌ | `none` |  The message you got the call to bulk delete |
| messages | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> or <span class="type">number</span> | ❌ | `none` |

 |





**Returns:** <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">{table,...}</a> The messages that were delet










### [compareRoles (role1, role2)](#compareRoles)
Compare 2 roles positions



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| role1 |  | ❌ | `none` |  The first role to compare |
| role2 |  | ❌ | `none` |  The second role to compare |





**Returns:** <span class="type">number</span> The distance from first role to seco










### [manageable (member)](#manageable)
Compare 2 roles positions



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| member |  | ❌ | `none` |  The member to see if the bot can manage |





**Returns:** <span class="type">boolean</span> If true, the bot can manage the member, else than n










### [checkPerm (member, channel, permissions)](#checkPerm)
Check if the member has permissions or a role override



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| member |  | ❌ | `none` |  The member to check the permissions of |
| channel |  | ❌ | `none` |  The channel that the member is using |
| permissions | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> | ❌ | `none` |  The permissions you want to check, eg kickMembers |












