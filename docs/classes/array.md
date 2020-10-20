
# Class `array`
An array with helper functions









### [Methods](#Methods)
| Property | Description |
| -------- | ----------- |
| array\new (...) | Takes in a vararg to populate the table |
| array\forEach (func) | For every item in the array, call the function |
| array\filter (func) | Loop through each item and each item that satifies the function gets added to an array and gets returned |
| array\find (func) | The first item to satify a function gets returned |
| array\map (func) | Create a new array based off what the passed function evaluates the data to |
| array\push (item) | Add an item to the array |
| array\slice ([start=1[, stop=#array[, step=1]]]) | Slice an array with a start, stop, and step |
| array\shift () | Remove the first in an array |
| array\pop (pos) | Remove the last or an index piece of data from an array |

### [Metamethods](#Metamethods)
| Property | Description |
| -------- | ----------- |
| array\__len () | Length of the list |
| array\__pairs () | Loop over the list |



## [Methods](#Methods)

### [array\new (...)](#array\new)
Takes in a vararg to populate the table



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| ... |  | ❌ | `none` |      |











### [array\forEach (func)](#array\forEach)
For every item in the array, call the function



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| func | <span class="type">function</span> | ❌ | `none` |      |











### [array\filter (func)](#array\filter)
Loop through each item and each item that satifies the function gets added to an array and gets returned



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| func | <span class="type">function</span> | ❌ | `none` |      |











### [array\find (func)](#array\find)
The first item to satify a function gets returned



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| func | <span class="type">function</span> | ❌ | `none` |      |











### [array\map (func)](#array\map)
Create a new array based off what the passed function evaluates the data to



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| func | <span class="type">function</span> | ❌ | `none` |      |











### [array\push (item)](#array\push)
Add an item to the array



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| item |  | ❌ | `none` |      |











### [array\slice ([start=1[, stop=#array[, step=1]]])](#array\slice)
Slice an array with a start, stop, and step



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| start | <span class="type">number</span> | ☑️ | `1` |  Where to start the slice |
| stop | <span class="type">number</span> | ☑️ | `#array` |  Where to stop the slice |
| step | <span class="type">number</span> | ☑️ | `1` |  The amount to step buy |











### [array\shift ()](#array\shift)
Remove the first in an array










### [array\pop (pos)](#array\pop)
Remove the last or an index piece of data from an array



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| pos | <span class="type">number</span> | ❌ | `none` |  Where to take the data out of |











## [Metamethods](#Metamethods)

### [array\__len ()](#array\__len)
Length of the list










### [array\__pairs ()](#array\__pairs)
Loop over the list











