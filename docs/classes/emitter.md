
# Class `emitter`
A embed helper class









### [Methods](#Methods)
| Property | Description |
| -------- | ----------- |
| emitter\new () | Create a new emitter |
| emitter\on (name, fn) | Listen to the emitter |
| emitter\once (name, fn) | Listen to the emitter once |
| emitter\emit (name, data) | Emit an event |
| emitter\removeListener (name, fn) | Remove a listener from an event |
| emitter\waitFor (name, timeout, predicate) | Wait for an event to be fired in a certain timeframe matching an optional predicate |



## [Methods](#Methods)

### [emitter\new ()](#emitter\new)
Create a new emitter










### [emitter\on (name, fn)](#emitter\on)
Listen to the emitter



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| name | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The name of the event |
| fn | <span class="type">function</span> | ❌ | `none` |  The callback function |











### [emitter\once (name, fn)](#emitter\once)
Listen to the emitter once



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| name | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The name of the event |
| fn | <span class="type">function</span> | ❌ | `none` |  The callback function |











### [emitter\emit (name, data)](#emitter\emit)
Emit an event



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| name | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The name of the event |
| data | optional <span class="type">{any,...}</span> | ❌ | `none` |  The data to emit |











### [emitter\removeListener (name, fn)](#emitter\removeListener)
Remove a listener from an event



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| name | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The name of the event |
| fn | <span class="type">function</span> | ❌ | `none` |  The callback function |











### [emitter\waitFor (name, timeout, predicate)](#emitter\waitFor)
Wait for an event to be fired in a certain timeframe matching an optional predicate



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| name | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The name of the event |
| timeout | optional <span class="type">number</span> | ❌ | `none` |  The amount of time to wait before timing out |
| predicate | optional <span class="type">function</span> | ❌ | `none` |  The function that has to return true in order to return a value |












