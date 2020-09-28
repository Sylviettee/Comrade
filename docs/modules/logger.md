
# Module `logger`
A module to make logging with colors easier









### [Functions](#Functions)
| Property | Descritpion |
| -------- | ----------- |
| palette () | An internal table to store the current palette |
| render (text, env) | Renders text put in |

### [Tables](#Tables)
| Property | Descritpion |
| -------- | ----------- |
| colors | A table containing color bit values |



## [Functions](#Functions)

### [palette ()](#palette)
An internal table to store the current palette










### [render (text, env)](#render)
Renders text put in



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| text | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The text to render with color |
| env | optional <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> | ❌ | `none` |  Some variables you can add to the renderer |





**Returns:** <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> rendered The rendered te










## [Tables](#Tables)

### [colors](#colors)
A table containing color bit values



| Fields | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| 8 |  | ❌ | `none` |  8 bit colors |
| 16 |  | ❌ | `none` |  16 bit colors |
| 256 |  | ❌ | `none` |  Some 256 bit colors |












