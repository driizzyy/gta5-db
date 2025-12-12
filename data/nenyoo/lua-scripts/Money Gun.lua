-- Money Gun Script for GTA V

-- Configuration
local modelHash = util.joaat("prop_money_bag_01")
local pickupHash = util.joaat("PICKUP_MONEY_VARIABLE")
local spawnDistance = 2.0 -- Distance in front of the player to spawn the money
local shootingInterval = 100 -- Time interval between money spawns (in milliseconds)
local toggle = false

local function Vector3multiply(u, v)
    return {x = u.x * v, y = u.y * v, z = u.z * v}
end

local function Vector3add(u, v)
    return {x = u.x + v.x, y = u.y + v.y, z = u.z + v.z}
end

-- Function to shoot money
local function shootMoney()
    local playerPed = util.getLocalPlayerHandle() -- should do in loop
    local playerCoords = util.getLocalPosition()
    local forwardVector = ENTITY.GET_ENTITY_FORWARD_VECTOR(playerPed)
    local forwardPosition = Vector3multiply(forwardVector, spawnDistance) -- you have bad arg here
    local spawnCoords = Vector3add(playerCoords, forwardPosition)
    if toggle then
        -- Check if the player is shooting
        if PED.IS_PED_SHOOTING(playerPed) then
            -- Spawn the money model
            local moneyObject = OBJECT.CREATE_AMBIENT_PICKUP(pickupHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, 0, 10000, modelHash, false, true)
            ENTITY.SET_ENTITY_VELOCITY(moneyObject, forwardVector.x * 10, forwardVector.y * 10, forwardVector.z * 10) -- Give money some velocity
        end
    end
end


script.addScript(shootMoney)
-- Main loop to monitor shooting
gui.createMainTab("Money Gun")
gui.addToggle("Shoot Money", "Guns shoot money.", false, function()
    toggle = not toggle
    if toggle then
        gui.pushNotification("Shoot Money", "Shoot money enabled!")
        else
        gui.pushNotification("Shoot Money", "Shoot money disabled!")
    end
end)