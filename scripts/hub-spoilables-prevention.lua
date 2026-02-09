-- Configuration: Frequency of the "freeze" pulse
local TICK_INTERVAL = settings.startup["spoil-update-tick-interval"].value

--- Core Logic: Resets the spoilage timer for all items in a given inventory
--- @param inventory LuaInventory? The inventory (Cargo Bay/Hub) to process
local function freeze_inventory(inventory)
    if not inventory or not inventory.valid then return end
    
    for i = 1, #inventory do
        local stack = inventory[i]
        
        -- valid_for_read: slot is not empty
        -- spoil_percent > 0: item is actually capable of spoiling
        if stack and stack.valid_for_read and stack.spoil_percent > 0 then
            local time_left = stack.spoil_tick - game.tick
            local max_life = stack.prototype.get_spoil_ticks(stack.quality)
            
            -- Set the new spoil tick to: Current Time + (Remaining Time + Interval)
            -- math.min ensures we never exceed the item's maximum possible freshness
            stack.spoil_tick = game.tick + math.min(max_life, time_left + TICK_INTERVAL)
        end
    end
end

--- Main Loop: Scans all existing space platforms
local function process_space_platforms()
    -- Platforms are categorized by the Force (Team) they belong to
    for _, force in pairs(game.forces) do
        for _, platform in pairs(force.platforms) do
            
            -- The 'hub' is the master entity for any platform
            local hub = platform.hub
            if hub and hub.valid then
                -- In Factorio 2.0, 'hub_main' represents the unified 
                -- inventory of the Hub and all attached Cargo Bays.
                local cargo_inventory = hub.get_inventory(defines.inventory.hub_main)
                freeze_inventory(cargo_inventory)
                -- For trash slots too
                local cargo_inventory_trash = hub.get_inventory(defines.inventory.hub_trash)
                freeze_inventory(cargo_inventory_trash)
            end
        end
    end
end

-- Register the logic to run every 5 seconds
script.on_nth_tick(TICK_INTERVAL, process_space_platforms)