--#region: Code for both distance multipiers and graphics changes

-- Distance scaling factor
local path_factor = settings.startup["distance-factor"].value

-- Logarithmic, since it can get wildly up 
-- Not an external setting
---@diagnostic disable-next-line: param-type-mismatch
local graphics_factor = math.log(path_factor,10)

-- Multiply the travel distance
for _, connection in pairs(data.raw["space-connection"]) do
    if connection.length then
        connection.length = connection.length * path_factor
    end
end

-- Multiply distance so planets look far away
for _, planet in pairs(data.raw["planet"]) do
    if planet.distance then 
        planet.distance = planet.distance * graphics_factor
    end
end

-- Multiply factor so locations look far away
for _, location in pairs(data.raw["space-location"]) do
    if location.distance then
        location.distance = location.distance * graphics_factor
    end
end

--Dunno what this actually does but works to slow background stars from being too fast
data.raw["utility-constants"]["default"]["space_platform_starfield_movement_vector"] = {0, -0.02 / (path_factor * 10)}

--#endregion