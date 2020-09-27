----
-- An array with helper functions
-- @classmod Array

class Array
  --- Takes in a vararg to populate the table
  new: (...) =>
    @data = {...}
  --- Length of the list
  __len: =>
    #@data

  --- Loop over the list
  __pairs: =>
    func = (tbl,k) ->
      local v

      k,v = next(tbl, k)

      if v then
        k,v
    
    func, @data, nil
  
  --- For every item in the array, call the function
  -- @tparam function func
  forEach: (func) =>
    for i,v in pairs @data
      func v,i,@data
  
  --- Loop through each item and each item that satifies the function gets added to an array and gets returned
  -- @tparam function func
  filter: (func) =>
    data = {}

    for _,v in pairs @data
      if func v
        table.insert data,v
    Array unpack data
  
  --- The first item to satify a function gets returned
  -- @tparam function func
  find: (func) =>
    for i,v in pairs @data
      if func v
        return v, i
  
  --- Create a new array based off what the passed function evaluates the data to
  -- @tparam function func
  map: (func) =>
    newData = {}

    for _,v in pairs @
      table.insert newData, func v
    Array unpack newData
  --- Add an item to the array
  -- @param item
  push: (item) =>
    table.insert @data, item

  --- Slice an array with a start, stop, and step
  -- @tparam[opt=1] number start Where to start the slice
  -- @tparam[opt=#array] number stop Where to stop the slice
  -- @tparam[opt=1] number step The amount to step buy
  slice: (start,stop,step) =>
    table.slice @data, start,stop,step

  --- Remove the first in an array
  shift: =>
    table.remove @data, 1

  --- Remove the last or an index piece of data from an array
  -- @tparam number pos Where to take the data out of
  pop: (pos) =>
    table.remove @data, pos