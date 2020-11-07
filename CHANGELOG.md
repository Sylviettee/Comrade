# Changelog

Changes between each version.

## 1.3.0

- Switch Lua class system
- Switch from MoonScript compiler to MoonPlus

## 1.2.5

- Subcommand class to allow for more separation
- More Lua helpers

## 1.2.4

- Removed blua as it caused compile issues
- Added more advanced argument parsing
- Docs generation change
- Moved advanced argument parsing test to examples
- Make LuaCheck happy
- Allow multiple prefixes
- Fixed bug where you can repeat the prefix and it'll still count; eg prefix `=`, `==` will trigger

## 1.2.3

- Allowed templates to output another template
- Allow prompts to render templates with the prompts current state
- Allowed for the use of etlua of a renderer
- Added docs for template
- Fixed bug where it won't send embeds in dms
- Fixed bug where the prompt will not check what channel
- More advanced argument parsing
- Added middleware to add features to commands

## 1.2.2

- Added blua, a better way to use MoonScript classes
- Passed client to events

## 1.2.1

- Added option to disable command handler
- Updated documentation for new testing options

## 1.2.0

- Large bug fixes
- Test suit
- Faker library for testing
- Lua check linting
- Makefile utility

## 1.1.0

- Examples be an array
- Fixed preconditions
- Check embed limits
- Unload events and separation for plugin and commands
- Examples for documentation

## 1.0.0

- Copied Comrade from other repo
- Upload docs
