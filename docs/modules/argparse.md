
# Module `argparse`
A module to parse arguments into a table





## See also

* [advanced-arguments.moon](../examples/advanced-arguments.moon.md#)






### [Functions](#Functions)
| Property | Description |
| -------- | ----------- |
| new (tbl, command) | Construct an argument parser |

### [Tables](#Tables)
| Property | Description |
| -------- | ----------- |
| argument | An argument |

### [Fields](#Fields)
| Property | Description |
| -------- | ----------- |
| int | The built in types; They are automatically type casted to what they are named |



## [Functions](#Functions)

### [new (tbl, command)](#new)
Construct an argument parser



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| tbl | <a class="type" href="../modules/argparse.md#argument">argument[]</a> | ❌ | `none` |  The argument table to parse |
| command | <a class="type" href="../classes/command.md#">command</a> | ❌ | `none` |  The command which you are using this on |











## [Tables](#Tables)

### [argument](#argument)
An argument



| Fields | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| id | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The key of where to put the argument |
| type | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The type of the argument |
| default | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> or <span class="type">function</span> | ☑️ | `nil` |  The default argument, if passed a function it will be passed the argument and message |











## [Fields](#Fields)

### [int](#int)
The built in types; They are automatically type casted to what they are named



| Property | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| int |  | ❌ | `none` |  Check if the input is a number |
| string |  | ❌ | `none` |  Does nothing as all inputs are strings |
| boolean |  | ❌ | `none` |  Check if the input is true or false |
| ban |  | ❌ | `none` |  Check if the input is a valid ban |
| channel |  | ❌ | `none` |  Check if the input is a channel; does not allow searching |
| emoji |  | ❌ | `none` |  Check if the input is a emoji |
| guild |  | ❌ | `none` |  Check if the input is a guild, will preform a search if the input is a string |
| invite |  | ❌ | `none` |  Check if the input is a invite code |
| member |  | ❌ | `none` |  Check if the input is a member; does not allow searching |
| message |  | ❌ | `none` |  Check if the input is message jump link or an id |
| role |  | ❌ | `none` |  Check if the input is a role, will preform a search if the input is a string |
| textchannel |  | ❌ | `none` |  Check if the input is a text channel, will preform a search if the input is a string |












