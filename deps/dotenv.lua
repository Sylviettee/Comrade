--- A module to parse a .env file
-- @module dotenv
local dotenv = {}

local fs = require('fs')
local path = require('path')

local function log(message)
    print('[Env]: ' .. message)
end

--- Parses a .env file, does't support everything yet
-- @tparam string src The contents of the .env file
-- @tparam boolean debug If the current mode is debug or not
-- @treturn table The parsed .env file
function dotenv.parse (src,debug)
    local obj = {}

    for idx,line in pairs(string.split(tostring(src),'\n')) do
        line = string.trim(line)
        local keyValueArr = string.split(line, "=")
        -- matched?
        if (#keyValueArr > 1) then
            local key = keyValueArr[1]
            -- default undefined or missing values to empty string
            local val = (keyValueArr[2] or '')
            local End = val:len()
            local isDoubleQuoted = val:sub(0,1) == '"' and val:sub(End,End) == '"'
            local isSingleQuoted = val:sub(0,1) == "'" and val:sub(End,End) == "'"

            -- if single or double quoted, remove quotes
            if (isSingleQuoted or isDoubleQuoted) then
                val = val:sub(2, End-1)
            else
                -- remove surrounding whitespace
                val = string.trim(val)
            end

            key = string.trim(key)

            if key:sub(0,1) ~= '#' then
              if tonumber(val) then
                obj[key] = tonumber(val)
              elseif val == 'true' then
                obj[key] = true
              elseif val == 'false' then
                obj[key] = false
              else
                obj[key] = val
              end
            end
        elseif debug then
            log('did not match key and value when parsing line ' .. idx .. ': ' .. line)
        end
    end
  return obj
end

--- Automatically read, parse, and inject a .env file
-- @tparam table options The options on how to parse the file
-- @treturn table The parsed .env file
function dotenv.config (options)
    local dotenvPath = path.resolve(process.cwd(), '.env')
    local encoding = 'utf8'
    local debug = false

    if options then
        if options.path then
            dotenvPath = options.path
        end
        if options.encoding then
            encoding = options.encoding
        end
        if options.debug then
            debug = true
        end
    end

    local Parsed

    local suc,err = pcall(function()
        local parsed = dotenv.parse(fs.readFileSync(dotenvPath, { encoding = encoding }), debug)

        for i,v in pairs(parsed) do
            if not process.env[i] then
                process.env[i] = v
            else
                if debug then
                    log(i .. ' is already already defined in `process.env` and will not be overwritten')
                end
            end
        end

        Parsed = {parsed}
    end)
    -- specifying an encoding returns a string instead of a buffer
    if not suc then
        error(err)
    end

    return Parsed
end

return dotenv