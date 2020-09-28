
# Class `client`
The helper client, extends a Discordia client









### [Functions](#Functions)
| Property | Description |
| -------- | ----------- |
| helper.__init (token[, config={}]) | Create a new helper client |
| helper.login (status) | Login to Discord |
| helper.resetErrors () | Reset the errors back to an empty array |
| helper.updateOwners (owners) | Update the owners list |
| helper.addCommand (command) | Add a command |
| helper.removeCommand (name, check) | Remove a command |
| helper.addEvent (event) | Add an event |
| helper.removeEvent (name, check) | Remove an event |
| helper.removePlugin (name) | Remove plugin |

### [Tables](#Tables)
| Property | Description |
| -------- | ----------- |
| client.config | The clients configuration (Most from Discordia client) |



## [Functions](#Functions)

### [helper.__init (token[, config={}])](#helper.__init)
Create a new helper client



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| token | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The Discord bot token |
| config | <a class="type" href="../classes/client.md#client.config">config</a> | ☑️ | `{}` |  The configuration of the client |











### [helper.login (status)](#helper.login)
Login to Discord



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| status | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> | ❌ | `none` |      |











### [helper.resetErrors ()](#helper.resetErrors)
Reset the errors back to an empty array










### [helper.updateOwners (owners)](#helper.updateOwners)
Update the owners list



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| owners | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> | ❌ | `none` |      |











### [helper.addCommand (command)](#helper.addCommand)
Add a command



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| command | <a class="type" href="../classes/command.md#">command</a> | ❌ | `none` |      |







**See also:**

* [command](../classes/command.md#)






### [helper.removeCommand (name, check)](#helper.removeCommand)
Remove a command



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| name | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |      |
| check | optional <span class="type">function</span> | ❌ | `none` |      |











### [helper.addEvent (event)](#helper.addEvent)
Add an event



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| event | <a class="type" href="../classes/event.md#">event</a> | ❌ | `none` |      |







**See also:**

* [event](../classes/event.md#)






### [helper.removeEvent (name, check)](#helper.removeEvent)
Remove an event



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| name | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |      |
| check | optional <span class="type">function</span> | ❌ | `none` |      |











### [helper.removePlugin (name)](#helper.removePlugin)
Remove plugin



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| name | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |      |











## [Tables](#Tables)

### [client.config](#client.config)
The clients configuration (Most from Discordia client)



| Fields | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| prefix | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ☑️ | `'!'` |  The prefix the bot will use |
| defaultHelp | <span class="type">boolean</span> | ☑️ | `true` |  Whether to use the default help or not |
| owners | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> | ☑️ | `{}` |  The owners of this bot |
| testing | <span class="type">boolean</span> | ☑️ | `false` |  Weather the bot is in testing or not |
| testbot | <span class="type">boolean</span> | ☑️ | `false` |  Weather this current bot is a test bot |
| botid | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ☑️ | `nil` |  The bot testing this current bot |
| storeErrors | <span class="type">boolean</span> | ☑️ | `false` |  Weather to store error information within a table |
| disableDefaultCH | <span class="type">boolean</span> | ☑️ | `false` |  Weather to disable the default command handler (Usually for custom prefixes) |
| routeDelay | <span class="type">number</span> | ☑️ | `300` |  Minimum time in milliseconds to wait between HTTP requests per-route |
| maxRetries | <span class="type">number</span> | ☑️ | `5` |  The maximum number of retries to attempt after an HTTP request fails |
| shardCount | <span class="type">number</span> | ☑️ | `0` |  The total number of shards the application is using (0 signals to use the recommended count) |
| firstShard | <span class="type">number</span> | ☑️ | `0` |  The ID of the first shard to run on the client (0 is the minimum) |
| lastShard | <span class="type">number</span> | ☑️ | `-1` |  The ID of the last shard to run on the client (-1 signals to use shardCount - 1) |
| largeThreshold | <span class="type">number</span> | ☑️ | `100` |  Limit to how many members are initially fetched per-guild on start-up |
| cacheAllMembers | <span class="type">boolean</span> | ☑️ | `false` |  Whether to cache all members (If false, offline members may not be cached) |
| autoReconnect | <span class="type">boolean</span> | ☑️ | `true` |  Whether to attempt to reconnect after an unexpected gateway disconnection |
| compress | <span class="type">boolean</span> | ☑️ | `true` |  Whether to allow for compressed gateway payloads |
| bitrate | <span class="type">number</span> | ☑️ | `64000` |  The default bitrate to use for voice connections, from 8000 to 128000 |
| logFile | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ☑️ | `'discordia.log'` |  The file to use for logging |
| logLevel | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ☑️ | `logLevel.info` |  The level to use for logging (see Enumerations) |
| dateTime | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ☑️ | `'%F %T'` |  The date and time format to use logging |
| syncGuilds | <span class="type">boolean</span> | ☑️ | `false` |  Whether to automatically sync all guilds on start up (user-accounts only) |












