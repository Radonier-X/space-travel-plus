--#region: Modify health

-- Asteroids become harder at higher speeds. This is to adjust it
local modify_asteroid_health = settings.startup["modify-asteroid-health"].value
local modify_upto_medium_only = settings.startup["modify-asteroid-health-upto-medium"].value
local asteroid_health_modification_percent = settings.startup["asteroid-health-modification-percent"].value
asteroid_health_modification_percent = asteroid_health_modification_percent/100

-- Unimplemented setting, will be done in future
-- Makes it so that the asteroids deal less damage to platforms
local modify_asteroid_weight = true
local asteroid_weight_modification_percent = 0.5

if modify_asteroid_health then
    for _, asteroid in pairs(data.raw["asteroid"]) do
    -- Check if the asteroid name contains "small" or "medium"
        name = asteroid.name

        if modify_upto_medium_only then
            if name:find("small") or name:find("medium") then
                if asteroid.max_health then
                    asteroid.max_health = asteroid.max_health * asteroid_health_modification_percent
                end
            end
        else 
            if asteroid.max_health then
                asteroid.max_health = asteroid.max_health * asteroid_health_modification_percent
            end
        end

        if modify_asteroid_weight then
            if asteroid.mass then
                asteroid.mass = asteroid.mass * asteroid_weight_modification_percent
            end
        end

    end
end

--#endregion