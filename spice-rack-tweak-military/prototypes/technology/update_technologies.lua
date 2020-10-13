local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Military Rebalance
if settingsutil.get_startup_setting("change-military-research") then
    -- name = "physical-projectile-damage-3",
    -- prerequisites = {"physical-projectile-damage-2"},
    --     unit =
    --     {
    --       count = 100*3,
    --       ingredients =
    --       {
    --         {"automation-science-pack", 1},
    --         {"logistic-science-pack", 1},
    --         {"military-science-pack", 1}
    --       },
    --       time = 60
    --     }

    data.raw.technology['physical-projectile-damage-3'].unit.time = 45

    -- name = "weapon-shooting-speed-1",
    -- prerequisites = {"military"},
    --     unit =
    --     {
    --       count = 100*1,
    --       ingredients =
    --       {
    --         {"automation-science-pack", 1}
    --       },
    --       time = 30
    --     },

    data.raw.technology['weapon-shooting-speed-1'].unit.count = 75
    data.raw.technology['weapon-shooting-speed-2'].unit.count = 150
    data.raw.technology['weapon-shooting-speed-3'].unit.count = 250
    data.raw.technology['weapon-shooting-speed-3'].unit.time = 45
    
    tableutil.remove(
            data.raw.technology['military-3'].unit.ingredients, 
            function (i) return i and i[1] == "chemical-science-pack" end)
    tableutil.remove(
            data.raw.technology['military-3'].prerequisites, 
            function (t) return t == "chemical-science-pack" end)

    data.raw.technology['military-3'].unit.count = 200
    
    tableutil.add(data.raw.technology['tanks'].prerequisites, "chemical-science-pack", true)

    tableutil.add(data.raw.technology['stronger-explosives-1'].prerequisites, "military-science-pack", true)
    
end
------ << Military Rebalance

------ >> Combat Robot Count
if settingsutil.get_startup_setting("change-robot-follower-count") then
    -- type = "technology",
    -- name = "combat-robotics",
    -- icon_size = 128,
    -- icon = "__base__/graphics/technology/combat-robotics.png",
    -- effects =
    -- {
    --     {
    --     type = "unlock-recipe",
    --     recipe = "defender-capsule"
    --     },
    --     {
    --     type = "maximum-following-robots-count",
    --     modifier = 4
    --     }
    -- },

    local _, effect = tableutil.find(
        data.raw.technology['combat-robotics'].effects,
        function (e) return e and e.type == "maximum-following-robots-count" end)

    if (effect and effect.modifier) then
        effect.modifier = 9
    end
end
------ << Combat Robot Count

------ >> Flamethrower

if settingsutil.get_startup_setting("flamethrower-change") then
    data.raw.technology['flamethrower'].unit.count = 200
end

------ << Flamethrower


------ >> Tank
if settingsutil.get_startup_setting("tank-change") then
    tableutil.add(data.raw.technology['tanks'].prerequisites, "electric-engine", true)
end
------ << Tank