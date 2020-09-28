
# Class `command`
A command helper class, should be extended









### [Methods](#Methods)
| Property | Description |
| -------- | ----------- |
| command\new () | Create a command |
| command\help (channel) | An function to generate a help embed and send to to a channel |
| command\pre () | An internal function to fill in all the data |
| command\check (command, msg, client) | An internal function to check if the message fits the command |
| command\addMiddleware (middleware) | A function that can be used to add extra functionality to commands like more advanced argument parsing |
| command\run (msg, args, client) | An internal function to run the command, it will check against preconditions if it exists |



## [Methods](#Methods)

### [command\new ()](#command\new)
Create a command










### [command\help (channel)](#command\help)
An function to generate a help embed and send to to a channel



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| channel | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> | ❌ | `none` |  The channel to send the message to |











### [command\pre ()](#command\pre)
An internal function to fill in all the data










### [command\check (command, msg, client)](#command\check)
An internal function to check if the message fits the command



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| command | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The command without arguments or prefix |
| msg | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> | ❌ | `none` |  The message that called the command |
| client | <a class="type" href="../classes/client.md#">client</a> | ❌ | `none` |  The client using the command |











### [command\addMiddleware (middleware)](#command\addMiddleware)
A function that can be used to add extra functionality to commands like more advanced argument parsing



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| middleware | <span class="type">middleware</span> | ❌ | `none` |  The middleware to add, should have execute function |











### [command\run (msg, args, client)](#command\run)
An internal function to run the command, it will check against preconditions if it exists



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| msg | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> | ❌ | `none` |  The message that called the command |
| args | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string[]</a> | ❌ | `none` |  The arguments of the message |
| client | <a class="type" href="../classes/client.md#">client</a> | ❌ | `none` |  The client that called the command |












