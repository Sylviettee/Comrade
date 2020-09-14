class
  @__name = 'Stack'
  new: (initialState = {}) =>
    @data = initialState
  
  __len: () =>
    #@data

  peek: () =>
    @data[#@data]

  push: (...) =>
    for _,v in pairs {...}
      table.insert @data, v

  pop: () =>
    table.remove @data

  forEach: (fn) => -- You can only read thats at the top of the stack
    for _ = 1, #@data
      fn @pop!
