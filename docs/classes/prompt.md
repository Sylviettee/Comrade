
# Class `prompt`
A prompt helper class









### [Tables](#Tables)
| Property | Description |
| -------- | ----------- |
| prompt.globalActions | Prompt global actions |
| prompt.config | Prompt configuration |
| prompt.task | A prompt task |

### [Methods](#Methods)
| Property | Description |
| -------- | ----------- |
| prompt\new (msg, client, config) | Construct a prompt to get user information |
| prompt\next () | Move on the prompt |
| prompt\back () | Go back on the prompt |
| prompt\redo () | Redo the current prompt task |
| prompt\close () | Close the prompt |
| prompt\reply (content) | Send a message in the prompt channel |
| prompt\save (key, value) | Save a value into the prompt |
| prompt\get (key) | Get a value from the prompt |
| prompt\handle (msg) | Internal; Handle the action |
| prompt\update () | Internal; Handle the message |



## [Tables](#Tables)

### [prompt.globalActions](#prompt.globalActions)
Prompt global actions



| Fields | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| check |  | ❌ | `none` |  A function that prompts the user to check their input data, to make data private prefix it with an underscore |











### [prompt.config](#prompt.config)
Prompt configuration



| Fields | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| embed | <span class="type">boolean</span> | ❌ | `none` |      |
| tasks | <a class="type" href="../classes/prompt.md#prompt.task">task[]</a> | ❌ | `none` |      |











### [prompt.task](#prompt.task)
A prompt task



| Fields | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| message | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> or <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> | ❌ | `none` |  The message of the task, if the embed flag is set, message has to be embed |
| action | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> or <span class="type">function</span> | ❌ | `none` |  If its a string, it has to be in global actions. Calls function with message content, prompt, and message object |











## [Methods](#Methods)

### [prompt\new (msg, client, config)](#prompt\new)
Construct a prompt to get user information



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| msg |  | ❌ | `none` |  The message |
| client |  | ❌ | `none` |  A Discordia or Comrade client |
| config | <a class="type" href="../classes/prompt.md#prompt.config">config</a> | ❌ | `none` |  A config containing the tasks, timeout, and if its an embed |











### [prompt\next ()](#prompt\next)
Move on the prompt










### [prompt\back ()](#prompt\back)
Go back on the prompt










### [prompt\redo ()](#prompt\redo)
Redo the current prompt task










### [prompt\close ()](#prompt\close)
Close the prompt










### [prompt\reply (content)](#prompt\reply)
Send a message in the prompt channel



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| content |  | ❌ | `none` |      |











### [prompt\save (key, value)](#prompt\save)
Save a value into the prompt



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| key |  | ❌ | `none` |      |
| value |  | ❌ | `none` |      |











### [prompt\get (key)](#prompt\get)
Get a value from the prompt



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| key |  | ❌ | `none` |      |











### [prompt\handle (msg)](#prompt\handle)
Internal; Handle the action



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| msg |  | ❌ | `none` |      |











### [prompt\update ()](#prompt\update)
Internal; Handle the message











