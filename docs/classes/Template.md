
# Class `Template`
A template for creating embeds and more templates









### [Methods](#Methods)
| Property | Description |
| -------- | ----------- |
| Template\new (start, useEtLua) | Create a new template |
| Template\render (env) | Render the template into an embed |
| Template\construct (env, useEtLua) | Render the template into another template |



## [Methods](#Methods)

### [Template\new (start, useEtLua)](#Template\new)
Create a new template



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| start | optional <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> | ❌ | `none` |  The starting point of the embed |
| useEtLua | optional <span class="type">boolean</span> | ❌ | `none` |  To use etlua as the renderer, mustache is the default renderer |











### [Template\render (env)](#Template\render)
Render the template into an embed



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| env | optional <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> | ❌ | `none` |  The table to pass to the renderer |











### [Template\construct (env, useEtLua)](#Template\construct)
Render the template into another template



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| env | optional <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> | ❌ | `none` |  The table to pass to the renderer |
| useEtLua | optional <span class="type">boolean</span> | ❌ | `none` |  To use etlua as the renderer, mustache is the default renderer |












