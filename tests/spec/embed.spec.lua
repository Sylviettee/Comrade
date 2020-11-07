return describe('embed class', function()
	local Embed
	do
		local _obj_0 = depend('../init')
		Embed = _obj_0.Embed
	end
	local char
	char = function(count)
		local str = ''
		for i = 1, count do
			str = str .. 'a'
		end
		return str
	end
	it('should be able to send embeds', function()
		assert(Embed({
			title = 'hi'
		}):send(tester.channel), 'No embed was sent')
		return assert(not tester.errored, 'Bot errored while testing')
	end)
	it('should prevent more than 25 fields', function()
		local embed = Embed()
		for i = 0, 30 do
			embed:addField("T: " .. tostring(i), "V: " .. tostring(i))
		end
		assert(embed:send(tester.channel), 'Failed to send')
		return assert(not tester.errored, 'Bot errored while testing')
	end)
	it('should prevent more than 256 characters in the title', function()
		local embed = Embed()
		embed:setTitle(char(300))
		assert(embed:send(tester.channel), 'No embed was sent')
		return assert(not tester.errored, 'Bot errored while testing')
	end)
	it('should prevent more than 2048 characters in the description', function()
		local embed = Embed()
		embed:setDescription(char(3000))
		assert(embed:send(tester.channel), 'No embed was sent')
		return assert(not tester.errored, 'Bot errored while testing')
	end)
	it('should prevent more than 2048 characters in the footer', function()
		local embed = Embed()
		embed:setFooter(char(3000))
		assert(embed:send(tester.channel), 'No embed was sent')
		return assert(not tester.errored, 'Bot errored while testing')
	end)
	it('should prevent more than 256 characters in the author', function()
		local embed = Embed()
		embed:setAuthor(char(300))
		assert(embed:send(tester.channel), 'No embed was sent')
		return assert(not tester.errored, 'Bot errored while testing')
	end)
	it('should prevent more than 256 characters in the field title', function()
		local embed = Embed()
		embed:addField(char(300), "E")
		assert(embed:send(tester.channel), 'Failed to send')
		return assert(not tester.errored, 'Bot errored while testing')
	end)
	return it('should prevent more than 1024 characters in the field value', function()
		local embed = Embed()
		embed:addField('E', char(2000))
		assert(embed:send(tester.channel), 'Failed to send')
		return assert(not tester.errored, 'Bot errored while testing')
	end)
end)
