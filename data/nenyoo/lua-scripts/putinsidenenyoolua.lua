gui.pushNotification("~p~Welcome", "~g~Advanced lua menu by z33d successfully loaded")

-- variables
local states = {
    god_mode = false,
    godmode_init = false,
    invisible = false,
    invisible_init = false,
    supercar = false,
    dirtLevel = 0,
    rapidFire = false,
    infiniteAmmo = false
}


function mainScript()
   local ped = util.getLocalPlayerHandle()

   if states.god_mode and not states.godmode_init then
       states.godmode_init = true
       ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
   elseif not states.god_mode and states.godmode_init then
       ENTITY.SET_ENTITY_INVINCIBLE(ped, false)
       states.godmode_init = false
   end

   if states.invisible and not states.invisible_init then
       states.invisible_init = true
       ENTITY.SET_ENTITY_VISIBLE(ped, false, false)
   elseif not states.invisible and states.invisible_init then
       ENTITY.SET_ENTITY_VISIBLE(ped, true, true)
       states.invisible_init = false
   end
end

script.addScript(mainScript)

-- gui
gui.createMainTab("~y~Advanced mod menu by z33d")

-- submenius
gui.addSub("~b~Player","player/self options.",0,function() end)
gui.addSub("~p~Vehicle","vehicle options.",1,function() end)
gui.addSub("~y~Recovery","reovery options.",2,function() end)
gui.addSub("~g~Weapons","weapon options.",3,function() end)

-- player
gui.createSubTab("~b~Player",0)
gui.addToggle("God Mode", "toggles invincibility", states.god_mode, function()
 states.god_mode = not states.god_mode
 gui.pushNotification("God Mode", states.god_mode and "Enabled" or "Disabled")
end)

gui.addToggle("Invisible Mode", "toggles invisibility.", states.invisible, function()
 states.invisible = not states.invisible
 gui.pushNotification("Invisible", states.invisible and "enabled" or "disabled")
end)


function vehicleSuperMode()
   if states.supercar then
      VEHICLE.SET_VEHICLE_FIXED(util.getLocalVehicleHandle())
   end
end
script.addScript(vehicleSuperMode)

-- vechicle
gui.createSubTab("~p~Vehicle",1)
gui.addToggle("Super Car", "your car becomes stronger", states.supercar, function()
 states.supercar = not states.supercar
 gui.pushNotification("Super Car", states.supercar and "enabled" or "disabled")
end)

gui.addInt("Dirt Level", "add or remove dirt from your vehicle", dirtLevel, 0, 100, 1, 1,false, function(newValue)
    dirtLevel = newValue
    VEHICLE.SET_VEHICLE_DIRT_LEVEL(util.getLocalVehicleHandle(), dirtLevel)
    gui.pushNotification("Dirt Level", dirtLevel == 0 and "your vehicle is clean" or "your vehicle is dirty")
end)

local car_modes = {"Normal","Sport","Offroad","Drift","Super"}
gui.addChoose("Drive Mode", "adjust handling of your current vehicle", car_modes, 0, false, function(selectedIndex)
    local vehicle = util.getLocalVehicleHandle()
    if vehicle == 0 then gui.pushNotification("drive mode", "your not in a vehicle") return end
    local mode = car_modes[selectedIndex + 1]
    if mode == "Sport" then
        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 100)
        VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(vehicle, 10)
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(vehicle, false)
    elseif mode == "Offroad" then
        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 30)
        VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(vehicle, 1)
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(vehicle, false)
    elseif mode == "Drift" then
        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 20)
        VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(vehicle, 999)
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(vehicle, true)
    elseif mode == "Super" then
        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 999)
        VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(vehicle, 999)
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(vehicle, true)
    else
        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 1000)
        VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(vehicle, 1000)
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(vehicle, false)
    end
    gui.pushNotification("Drive Mode", mode .. " mode activated")
end)

gui.addButton("Spawn Vehicle", "Spawn Vehicle by nmae.", function()
    script.queue(function() 
        local input = util.getKeyboardInput()
        if input == "" then gui.pushNotification("Spawn Vehicle", "you need to input a vehicle name") return end
        local model = util.joaat(input)
        if util.requestModel(model) then
            local ped = PLAYER.PLAYER_PED_ID()
            local pos = ENTITY.GET_ENTITY_COORDS(ped)
            local heading = ENTITY.GET_ENTITY_HEADING(ped)
            local vehicle = VEHICLE.CREATE_VEHICLE(model, pos.x, pos.y, pos.z, heading, true, false)
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, true, true)
            PED.SET_PED_INTO_VEHICLE(ped, vehicle, -1)
            gui.pushNotification("Spawn Vehicle", "success spawn vehicle")
        else
            gui.pushNotification("Spawn Vehicle", "failed to spawn vehicle wrong name")
        end
    end)
end)

-- recovery tab
local nightClubLoopToggle = false
function nightClubLoop()
    if not nightClubLoopToggle then return end
    if thread.isThreadRunning("am_mp_nightclub") then
        STATS.STAT_SET_INT(util.joaat(util.getMPX() .. "CLUB_POPULARITY"), 1000, true)
        STATS.STAT_SET_INT(util.joaat(util.getMPX() .. "CLUB_PAY_TIME_LEFT"), -1, true)
        script.wait(1000)
    end
end
script.addScript(nightClubLoop)
gui.createSubTab("Recovery",2)
gui.addToggle("Night Club Loop", "Toggles Night Club loop", nightClubLoopToggle, function()
    nightClubLoopToggle = not nightClubLoopToggle
    gui.pushNotification("Night Club Loop", nightClubLoopToggle and "Enabled" or "Disabled")
end)
-- drop money
gui.addButton("~g~Drop Money", "money dropper", function()
    script.queue(function()
        local playerPos = util.getLocalPosition()
        local playerForward = ENTITY.GET_ENTITY_FORWARD_VECTOR(util.getLocalPlayerHandle())

        local dropX = playerPos.x + playerForward.x * 1.0
        local dropY = playerPos.y + playerForward.y * 1.0
        local dropZ = playerPos.z + 0.5

        OBJECT.CREATE_MONEY_PICKUPS(dropX, dropY, dropZ, 100000, 5, 0x113FD533)
    end)
end)
-- weapons tab
gui.createSubTab("Weapons",3)
gui.addToggle("Rapid Fire", "makes your gun shoot faster", states.rapidFire, function()
    states.rapidFire = not states.rapidFire
    gui.pushNotification("Rapid Fire", states.rapidFire and "enabled" or "disabled")
end)
-- infinite ammo
gui.addToggle("Toggle Infinite Ammo", "enable/disable infinite bullets for current weapon", infiniteAmmoToggle, function()
    infiniteAmmoToggle = not infiniteAmmoToggle
    if infiniteAmmoToggle then
        gui.pushNotification("Infinite Ammo", "infinite ammo enabled")
    else
        gui.pushNotification("Infinite Ammo", "infinite ammo disabled")
    end
end)
-- inf ammo function
function infiniteAmmoLoop()
    if not infiniteAmmoToggle then return end

    local playerPed = PLAYER.PLAYER_PED_ID()

    if not PED.IS_PED_INJURED(playerPed) then
        local currentWeapon = WEAPON.GET_SELECTED_PED_WEAPON(playerPed)
        if currentWeapon ~= 0 then
            WEAPON.SET_PED_INFINITE_AMMO(playerPed, true, currentWeapon)
        end
    end
end

script.addScript(infiniteAmmoLoop)
