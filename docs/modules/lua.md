
# Module `lua`
Allows lua to create and extend classes









### [Functions](#Functions)
| Property | Description |
| -------- | ----------- |
| class (name, tbl, extend, setup) | Create a moonscript class |



## [Functions](#Functions)

### [class (name, tbl, extend, setup)](#class)
Create a moonscript class



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| name | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The name of the class |
| tbl | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> | ❌ | `none` |  Methods to add to the class |
| extend | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> or <span class="type">boolean</span> | ❌ | `none` |  The class to extend or false |
| setup | <span class="type">function</span> | ❌ | `none` |  The new method of the class |





**Returns:** <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> The class that was creat











