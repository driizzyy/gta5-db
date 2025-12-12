gui.createMainTab("Cash Dropper")

gui.addButton("Drop Cash On Self", "Drop $1,000,000 around your feet.", function()
	script.queue(function()
		local playerPosition = util.getLocalPosition()
		playerPosition.z = playerPosition.z + 3
		-- Drop 2 pickups of $500,000 = $1,000,000
		OBJECT.CREATE_MONEY_PICKUPS(playerPosition.x, playerPosition.y, playerPosition.z, 500000, 2, 0x113FD533)
	end)
end)

gui.addButton("Drop Cash Away From Self", "Drop $1,000,000 a few feet away from you.", function()
	script.queue(function()
		local playerPosition = util.getLocalPosition()
		local playerForward = ENTITY.GET_ENTITY_FORWARD_VECTOR(util.getLocalPlayerHandle())
		playerPosition.z = playerPosition.z + 3
		local spawnDistance = 5
		local forwardPosition = Vector3.multiply(playerForward, spawnDistance)
		local spawnPosition = Vector3.add(playerPosition, forwardPosition)
		-- Drop 2 pickups of $500,000 = $1,000,000
		OBJECT.CREATE_MONEY_PICKUPS(spawnPosition.x, spawnPosition.y, spawnPosition.z, 500000, 2, 0x113FD533)
	end)
end)

function Vector3.add(u, v)
    return Vector3.new(u.x + v.x, u.y + v.y, u.z + v.z)
end

function Vector3.multiply(u, v)
    return Vector3.new(u.x * v, u.y * v, u.z * v)
end
