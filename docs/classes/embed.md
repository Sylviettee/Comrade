
# Class `embed`
A embed helper class









### [Tables](#Tables)
| Property | Description |
| -------- | ----------- |
| embed.field | An embed field |

### [Methods](#Methods)
| Property | Description |
| -------- | ----------- |
| embed\addField (name, value[, inline=false]) | Add a field to the embed with name, value, and inline |
| embed\addFields (fields) | Add fields to the embed |
| embed\setAuthor (name, iconURL, url) | Set the author of the embed |
| embed\setColor (color) | Set the color of the embed |
| embed\setDescription (description) | Set the description of the embed |
| embed\setFooter (text, iconURL) | Set the footer of the embed |
| embed\setImage (url) | Set the image of the embed |
| embed\setThumbnail (url) | Set the thumbnail of the embed |
| embed\setTimestamp ([timestamp=Date!.toISO!]) | Set the timestamp of the embed, defaults to right now |
| embed\setTitle (title) | Set the title of the embed |
| embed\setURL (url) | Set the url of the embed |
| embed\toJSON () | Returns the embed object without any metatables |
| embed\send (channel) | Sends the embed and checks if we have permissions to |



## [Tables](#Tables)

### [embed.field](#embed.field)
An embed field



| Fields | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| name | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The name of the field |
| value | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The value of the field |
| inline | <span class="type">boolean</span> | ☑️ | `false` |  If the field is inline |











## [Methods](#Methods)

### [embed\addField (name, value[, inline=false])](#embed\addField)
Add a field to the embed with name, value, and inline



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| name | <a class="type" href="../classes/embed.md#embed.field">field</a> or <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The name of the field or an embed object |
| value | optional <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The value of the field, optional if name is field |
| inline | <span class="type">boolean</span> | ☑️ | `false` |  If the field is inline |





**Returns:** <a class="type" href="../classes/embed.md#">embed</a>










### [embed\addFields (fields)](#embed\addFields)
Add fields to the embed



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| fields | <a class="type" href="../classes/embed.md#embed.field">{field,...}</a> or <span class="type">{name,value,inline}...</span> | ❌ | `none` |  The fields to add, max 25 |





**Returns:** <a class="type" href="../classes/embed.md#">embed</a>










### [embed\setAuthor (name, iconURL, url)](#embed\setAuthor)
Set the author of the embed



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| name | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The author name |
| iconURL | optional <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The icon of the author |
| url | optional <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The url of the author |





**Returns:** <a class="type" href="../classes/embed.md#">embed</a>










### [embed\setColor (color)](#embed\setColor)
Set the color of the embed



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| color | <span class="type">hex</span> | ❌ | `none` |  The color in hex eg 0xFFFFFF |





**Returns:** <a class="type" href="../classes/embed.md#">embed</a>










### [embed\setDescription (description)](#embed\setDescription)
Set the description of the embed



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| description | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The description of the embed |





**Returns:** <a class="type" href="../classes/embed.md#">embed</a>










### [embed\setFooter (text, iconURL)](#embed\setFooter)
Set the footer of the embed



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| text | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The footer text |
| iconURL | optional <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The icon of the footer |





**Returns:** <a class="type" href="../classes/embed.md#">embed</a>










### [embed\setImage (url)](#embed\setImage)
Set the image of the embed



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| url | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The image url of the embed |





**Returns:** <a class="type" href="../classes/embed.md#">embed</a>










### [embed\setThumbnail (url)](#embed\setThumbnail)
Set the thumbnail of the embed



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| url | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The thumbnail url of the embed |





**Returns:** <a class="type" href="../classes/embed.md#">embed</a>










### [embed\setTimestamp ([timestamp=Date!.toISO!])](#embed\setTimestamp)
Set the timestamp of the embed, defaults to right now



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| timestamp | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ☑️ | `Date!.toISO!` |  The timestamp in ISO 8601 |





**Returns:** <a class="type" href="../classes/embed.md#">embed</a>










### [embed\setTitle (title)](#embed\setTitle)
Set the title of the embed



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| title | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The title of the embed |





**Returns:** <a class="type" href="../classes/embed.md#">embed</a>










### [embed\setURL (url)](#embed\setURL)
Set the url of the embed



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| url | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.4">string</a> | ❌ | `none` |  The url of the embed |





**Returns:** <a class="type" href="../classes/embed.md#">embed</a>










### [embed\toJSON ()](#embed\toJSON)
Returns the embed object without any metatables




**Returns:** <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a>










### [embed\send (channel)](#embed\send)
Sends the embed and checks if we have permissions to



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| channel | <a class="type" href="https://www.lua.org/manual/5.1/manual.html#5.5">table</a> | ❌ | `none` |  The channel to send the embed into |












