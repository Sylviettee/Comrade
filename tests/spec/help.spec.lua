return describe('help command', function()
	it('should display commands', function()
		local msg = assert(execute(tostring(bot.prefix) .. "help"))
		local help = msg.embeds[1]
		assert(help.title == 'Help', "Help title not 'Help'")
		local desc = ''
		bot.commands:forEach(function(command)
			desc = tostring(desc) .. ", `" .. tostring(command.name) .. "`"
		end)
		desc = desc:sub(2, #desc)
		assert(desc:trim() == help.description, "Help description does not match '" .. tostring(desc:trim()) .. "'")
		return assert(not tester.errored, 'Bot errored while testing')
	end)
	return it('should give information about a command', function()
		local msg = assert(execute(tostring(bot.prefix) .. "help help"))
		local help = bot.commands:find(function(command)
			return command.name == 'help'
		end)
		local embed = msg.embeds[1]
		assert(embed.title == 'Help', "Help title not 'Help'")
		local fields = { }
		for _, v in pairs(embed.fields) do
			fields[v.name] = v.value:trim()
		end
		assert(fields.Description == help.description:trim(), 'Help description not same')
		assert(fields.Usage == help.usage:trim(), 'Usages are not the same')
		assert(fields.Example == help.formatted:trim(), 'Examples are not the same')
		assert(fields.Aliases == ((table.concat(help.aliases, ', ') == '' and 'None') or (table.concat(help.aliases, ', ') ~= '' and table.concat(help.aliases, ', '))):trim(), 'Help aliases are not the same')
		assert(fields.Subcommands == ((table.concatIndex(help.subcommands, ', ') == '' and 'None') or (table.concatIndex(help.subcommands, ', ') ~= '' and table.concatIndex(help.subcommands, ', '))):trim(), 'Help subcommands are not the same')
		return assert(not tester.errored, 'Bot errored while testing')
	end)
end)
