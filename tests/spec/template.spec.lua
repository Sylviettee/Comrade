return describe('template class', function()
	local Template
	do
		local _obj_0 = depend('../init')
		Template = _obj_0.Template
	end
	it('should render a template', function()
		local level = Template({
			title = '{{user}} just got to level {{level}}',
			description = '{{user}} got to level {{level}}! You now have {{coins}} coins!'
		})
		local embed = level:render({
			user = '4 times 1 is even less than 0#3870',
			level = 5,
			coins = '2'
		})
		local raw = embed:toJSON()
		assert(raw.title == '4 times 1 is even less than 0#3870 just got to level 5', 'Title does not match')
		assert(raw.description == '4 times 1 is even less than 0#3870 got to level 5! You now have 2 coins!', 'Description does not match')
		assert(embed:send(tester.channel), 'Failed to send')
		return assert(not tester.errored, 'Bot errored while testing')
	end)
	it('should allow full use of handlebars', function()
		local leaderboard = Template({
			title = "{{guild}}'s leaderboard",
			description = '\n    {{#members}}\n    {{name}} - {{level}}\n    {{/members}}\n    '
		})
		local embed = leaderboard:render({
			guild = 'Our Cult',
			members = {
				{
					name = 'Github Issues',
					level = 100
				},
				{
					name = '4 times 1 is even less than 0',
					level = 5
				}
			}
		})
		assert(embed:send(tester.channel), 'Failed to send')
		return assert(not tester.errored, 'Bot errored while testing')
	end)
	return it('should render fields', function()
		local fields = Template({
			title = 'Fun'
		})
		for i = 1, 5 do
			fields:addField("{{name}}" .. tostring(i), "{{bio}}")
		end
		local embed = fields:render({
			name = 'Soviet',
			bio = 'Pro bug creator'
		})
		local sent = assert(embed:send(tester.channel), 'Failed to send')
		fields = { }
		for _, v in pairs(sent.embeds[1].fields) do
			fields[v.name] = v.value:trim()
		end
		assert(fields.Soviet1 == 'Pro bug creator', 'Failed to render a field')
		return assert(not tester.errored, 'Bot errored while testing')
	end)
end)
