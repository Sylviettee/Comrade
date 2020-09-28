
# Module `dotenv`
A module to parse a .env file









### [Functions](#Functions)
| Property | Descritpion |
| -------- | ----------- |
| parse (src, options) | Parses a .env file, does&#039;t support everything yet |
| config (options) | Automatically read, parse, and inject a .env file |



## [Functions](#Functions)

### [parse (src, options)](#parse)
Parses a .env file, does't support everything yet



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| src | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The contents of the .env file |
| options | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> | ❌ | `none` |  Contains if it is debug mode or not |





**Returns:** <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> The parsed .env fi










### [config (options)](#config)
Automatically read, parse, and inject a .env file



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| options | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> | ❌ | `none` |  The options on how to parse the file |





**Returns:** <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> The parsed .env fi











