stds.faker = {
  globals = {
    "tester", "it", "describe",
    "bot", "execute", "depend"
  }
}

unused_args = false

exclude_files = {"libs", "deps", "examples"}

ignore = { 
  "143", "631",
  "421", "422", "423", "431", "432", "433"
}

globals = {
  "p", "process"
}

std = "luajit"

files["tests/spec/**.lua"].std = '+faker'