--#region: Space asteroid definitions

local path_factor = settings.startup["distance-factor"].value

local modify_asteroid_connection_definitions = settings.startup["modify-asteroid-definition"].value

-- I have no fucking idea how this affects the game, asteroid defs are HARD
if modify_asteroid_connection_definitions then
    for _, connection in pairs(data.raw["space-connection"]) do
        if connection.asteroid_spawn_definitions then
            for _, definition in pairs(connection.asteroid_spawn_definitions) do

                -- definition[1] is the asteroid name (e.g., "metallic-asteroid-chunk")
                -- definition[2] is the array of spawn points
                local spawn_points = definition[2] or definition.spawn_points
                
                if spawn_points then
                    for _, point in pairs(spawn_points) do

                        -- The probability is located here, inside each spawn point
                        if point.probability then
                            point.probability = point.probability / path_factor
                        end

                        -- Reducing this makes asteroids drift slower relative to your high ship speed
                        if point.speed then
                            point.speed = point.speed / path_factor
                        end
                        
                    end
                end
            end
        end
    end
end

--#endregion
