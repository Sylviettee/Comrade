
# Class `Array`
An array with helper functions









### [Methods](#Methods)
| Property | Descritpion |
| -------- | ----------- |
| Array\new (...) | Takes in a vararg to populate the table |
| Array\forEach (func) | For every item in the array, call the function |
| Array\filter (func) | Loop through each item and each item that satifies the function gets added to an array and gets returned |
| Array\find (func) | The first item to satify a function gets returned |
| Array\map (func) | Create a new array based off what the passed function evaluates the data to |
| Array\push (item) | Add an item to the array |
| Array\slice ([start=1[, stop=#array[, step=1]]]) | Slice an array with a start, stop, and step |
| Array\shift () | Remove the first in an array |
| Array\pop (pos) | Remove the last or an index piece of data from an array |

### [Metamethods](#Metamethods)
| Property | Descritpion |
| -------- | ----------- |
| Array\__len () | Length of the list |
| Array\__pairs () | Loop over the list |



## [Methods](#Methods)

### [Array\new (...)](#Array\new)
Takes in a vararg to populate the table



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| ... |  | ❌ | `none` |

 |











### [Array\forEach (func)](#Array\forEach)
For every item in the array, call the function



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| func | <span class="type">function</span> | ❌ | `none` |

 |











### [Array\filter (func)](#Array\filter)
Loop through each item and each item that satifies the function gets added to an array and gets returned



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| func | <span class="type">function</span> | ❌ | `none` |

 |











### [Array\find (func)](#Array\find)
The first item to satify a function gets returned



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| func | <span class="type">function</span> | ❌ | `none` |

 |











### [Array\map (func)](#Array\map)
Create a new array based off what the passed function evaluates the data to



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| func | <span class="type">function</span> | ❌ | `none` |

 |











### [Array\push (item)](#Array\push)
Add an item to the array



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| item |  | ❌ | `none` |

 |











### [Array\slice ([start=1[, stop=#array[, step=1]]])](#Array\slice)
Slice an array with a start, stop, and step



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| start | <span class="type">number</span> | ☑️ | `1` |  Where to start the slice |
| stop | <span class="type">number</span> | ☑️ | `#array` |  Where to stop the slice |
| step | <span class="type">number</span> | ☑️ | `1` |  The amount to step buy |











### [Array\shift ()](#Array\shift)
Remove the first in an array










### [Array\pop (pos)](#Array\pop)
Remove the last or an index piece of data from an array



| Parameters | Type | Optional | Default | Description |
| --------------- | ---- | -------- | ------- | ----------- |
| pos | <span class="type">number</span> | ❌ | `none` |  Where to take the data out of |











## [Metamethods](#Metamethods)

### [Array\__len ()](#Array\__len)
Length of the list










### [Array\__pairs ()](#Array\__pairs)
Loop over the list











