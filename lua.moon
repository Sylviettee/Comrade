--- Allows lua to create and extend classes
-- @module lua
lua = {}

_super = (cls, self, method, ...) ->
  fn = if method == "new"
    cls.__parent.__init
  else
    cls.__parent.__base[method]

  fn @, ...

--- Create a moonscript class
-- @tparam string name The name of the class
-- @tparam table tbl Methods to add to the class
-- @tparam table|boolean extend The class to extend or false
-- @tparam function setup The new method of the class
-- @treturn table The class that was created
lua.class = (name, tbl, extend, setup) ->
  cls = if extend
    class extends extend
      new: tbl and tbl.new
      @super: _super
      @__name: name

      if tbl
        tbl.new = nil
        for k,v in pairs tbl
          @__base[k] = v

      setup and setup @
  else
    class
      new: tbl and tbl.new
      @super: _super
      @__name: name

      if tbl
        tbl.new = nil
        for k,v in pairs tbl
          @__base[k] = v

      setup and setup @

  cls

lua