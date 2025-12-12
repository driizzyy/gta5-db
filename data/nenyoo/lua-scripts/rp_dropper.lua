
gui.createMainTab("RP Dropper")

gui.addButton("Spawn Action Figure On Self", "Spawns an RP-giving collectible.", function()
script.queue(function()
    local playerPosition = util.getLocalPosition()
    playerPosition.z = playerPosition.z + 1.5

    -- Action Figure Pickup Hash: 0x2C014CA6 (PROP_ACTION_FIGURE_01)
    -- Request the model before spawning it
    local modelHash = util.joaat("vw_prop_vw_collectible_action_figure")
    STREAMING.REQUEST_MODEL(modelHash)
    while not STREAMING.HAS_MODEL_LOADED(modelHash) do
        util.yield()
    end

    -- Create the pickup (custom script pickup with the collectible model)
    local pickupHash = util.joaat("PICKUP_CUSTOM_SCRIPT")
    OBJECT.CREATE_AMBIENT_PICKUP(pickupHash, playerPosition.x, playerPosition.y, playerPosition.z, 0, 0, modelHash, false, true)
end)
end)
