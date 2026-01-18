--[[

Original expression

drag_coefficient = width * 0.5
drag = ((1500 * speed * speed + 1500 * abs(speed)) * drag_coefficient + 10000) * sign(speed)
final_thrust = thrust / (1 + weight / 10000000)
acceleration = (final_thrust - drag) / weight / 60

"((thrust / (1 + weight / 10000000) - ((1500 * speed * speed + 1500 * abs(speed)) / 1000 * (width * 0.5) + 10000) * sign(speed)) / weight / 60" )* 1000

]]--

--#region: Code for thrust expression modifiers

--#region: Brake drag


-- stop drag -> A way to reduce speed when thrust is not applied (only when engines are stopped)

-- Issues: This also applies when platforms are midway too (intended for orbits only)

-- (1 - sign(abs(thrust)))                      -> A way of finding if thrusters are on or not 
--                                                 (abs -> positive, sign -> 0 or 1, 1-sign -> invert 0 and 1)
-- brake drag coefficient                       -> How much braking force is applied in comparison to speed 
--                                                 (i.e 2 is two times the speed, 0.5 is half the speed)
-- brake drag speed power                       -> The type of de-acceleration. Higher powers result in sharper speed decreases

-- UNUSED:
-- min speed                                    -> The speed upto witch brakes are applied
-- (max("..min_speed..",speed)-"..min_speed..") -> A way to find if speed is greater than minimum speed
--                                                 When speed is lower than min speed, expression will evaluate to 0

local brake_drag_enabled = settings.startup["brake-drag-enabled"].value
local brake_drag = ""

if brake_drag_enabled then
    local brake_drag_coeff = 10
    local brake_drag_speed_power = 1

    --UNUSED
    local min_speed = 600 --km/s
    min_speed = min_speed / 60  --km/tick

    brake_drag = "- ("..brake_drag_coeff.." * (1 - sign(abs(thrust))) * speed ^ "..brake_drag_speed_power..")"
else 
    brake_drag = " "
end

--#endregion

--#region: Accleration expressions

-- Note: Accelration is abbrevated as accln

-- Max speed is the maximum speed of space platform
-- Lol its the speed of light
local max_speed = settings.startup["platform-max-speed"].value --km/s
max_speed = max_speed / 60 --km/tick

-- Choice of fourmula to be used
local accln_choice = settings.startup["acceleration-formula"].value

-- Collection of formulae
local accln_expressions =
{
    ["relativistic"]="((1 - (abs(speed) / "..max_speed.." ) ^ 2 ) ^ 1.5 )", -- Relativistic accln (fast upto max, emulates real life)
    ["quadratic"]="(1 - (abs(speed) / "..max_speed..") ^ 2)", -- Quadratic accln (midway accln decreases)
    ["linear"]="(1 - (abs(speed) / "..max_speed.."))" -- Linear accln (constant decrease)
}

-- Final choice
local accln_expression = accln_expressions[accln_choice]

--#endregion

--#region: Thrust and weight

-- Weight affecting thrust (exponential scale)
local weight_factor = settings.startup["weight-factor"].value
weight_factor = 10 ^ weight_factor

local thrust_expresion = "(thrust / (1 + weight / "..weight_factor.."))"

--#endregion

data.raw["utility-constants"]["default"]["space_platform_acceleration_expression"] = "("..thrust_expresion.." * "..accln_expression..""..brake_drag.." ) / weight / 60"


-- Startup Info
log(thrust_expresion)
log(accln_expression)
log(brake_drag)
log(data.raw["utility-constants"]["default"]["space_platform_acceleration_expression"] )

--#endregion