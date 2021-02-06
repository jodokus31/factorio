local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Military Research
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
    
    -- tableutil.add(data.raw.technology['stronger-explosives-1'].prerequisites, "military-science-pack", true)
    -- tableutil.add(data.raw.technology['stronger-explosives-1'].unit.ingredients, {"military-science-pack", 1}, true)
    -- data.raw.technology['stronger-explosives-1'].unit.count = 75
    
end
------ << Military Research

------ >> Military 3 Research
if settingsutil.get_startup_setting("change-military3-research") then

    tableutil.remove(
            data.raw.technology['military-3'].unit.ingredients, 
            function (i) return i and i[1] == "chemical-science-pack" end)
    tableutil.remove(
            data.raw.technology['military-3'].prerequisites, 
            function (t) return t == "chemical-science-pack" end)

    data.raw.technology['military-3'].unit.count = 200
    
    tableutil.add(data.raw.technology['tank'].prerequisites, "chemical-science-pack", true)
end

if settingsutil.get_startup_setting("longrange-turret") then
    if not settingsutil.get_startup_setting("change-military3-research") then
        tableutil.add(data.raw.technology['longrange-turret'].prerequisites, "chemical-science-pack", true)
        data.raw.technology['longrange-turret'].unit.count = 200
    end
end
------ << Military 3 Research

------ >> Combat Robot Count
if settingsutil.get_startup_setting("change-follower-robot-count") then
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

    -- local _, effect = tableutil.find(
    --     data.raw.technology['combat-robotics'].effects,
    --     function (e) return e and e.type == "maximum-following-robots-count" end)

    -- if (effect and effect.modifier) then
    --     effect.modifier = 9
    -- end

    -- type = "technology",
    -- name = "follower-robot-count-1",
    -- create_follower_upgrade(1, 1, 1, 0, 1, 0, 0, 200, 5),
    -- create_follower_upgrade(2, 1, 1, 0, 1, 0, 0, 300, 5),

    -- create_follower_upgrade(3, 1, 1, 1, 1, 0, 0, 400, 5),
    -- create_follower_upgrade(4, 1, 1, 1, 1, 0, 0, 600, 10),

    -- create_follower_upgrade(5, 1, 1, 1, 1, 1, 0, 800, 10),
    -- create_follower_upgrade(6, 1, 1, 1, 1, 1, 0, 1000, 10)

    data.raw.technology['follower-robot-count-1'].unit.count = 100
    data.raw.technology['follower-robot-count-2'].unit.count = 200
    data.raw.technology['follower-robot-count-3'].unit.count = 300
    data.raw.technology['follower-robot-count-4'].unit.count = 500
    data.raw.technology['follower-robot-count-5'].unit.count = 500
    data.raw.technology['follower-robot-count-6'].unit.count = 500
end
------ << Combat Robot Count

------ >> Flamethrower

if settingsutil.get_startup_setting("flamethrower-change") then
    data.raw.technology['flamethrower'].unit.count = 200

    local refined_flammables_modifiers = {
        ['refined-flammables-1'] = 0.4, -- 0.2
        ['refined-flammables-2'] = 0.5, -- 0.2
        ['refined-flammables-3'] = 0.6, -- 0.2
        ['refined-flammables-4'] = 0.8, -- 0.3
        ['refined-flammables-5'] = 1.0, -- 0.3
        ['refined-flammables-6'] = 1.2, -- 0.4
        ['refined-flammables-7'] = 0.6, -- 0.2
    }

    for tech, modifier in pairs(refined_flammables_modifiers) do
        for _, effect in pairs(data.raw.technology[tech].effects) do
            if effect and effect.type == "ammo-damage" then
                effect.modifier = modifier
            elseif effect and effect.type == "turret-attack" then
                effect.modifier = modifier
            end
        end
    end

end

------ << Flamethrower

------ >> Gun turret

if settingsutil.get_startup_setting("gun-turret-damage-change") then
    
    local damage_modifiers = {
        ['physical-projectile-damage-1'] = { ammo=0.1, gun_turret=0.1,  longrange_turret=nil  }, -- 0.1, 0.1, 
        ['physical-projectile-damage-2'] = { ammo=0.1, gun_turret=0.1,  longrange_turret=nil  }, -- 0.1, 0.1, 
        ['physical-projectile-damage-3'] = { ammo=0.2, gun_turret=0.1,  longrange_turret=0.1  }, -- 0.2, 0.2, 0.2
        ['physical-projectile-damage-4'] = { ammo=0.2, gun_turret=0.1,  longrange_turret=0.15 }, -- 0.2, 0.2, 0.25
        ['physical-projectile-damage-5'] = { ammo=0.2, gun_turret=0.15, longrange_turret=0.15 }, -- 0.2, 0.2, 0.3
        ['physical-projectile-damage-6'] = { ammo=0.4, gun_turret=0.15, longrange_turret=0.15 }, -- 0.4, 0.4, 0.45
        ['physical-projectile-damage-7'] = { ammo=0.4, gun_turret=0.15, longrange_turret=0.20 }, -- 0.4, 0.7, 0.75
    }

    for tech, modifiers in pairs(damage_modifiers) do
        for _, effect in pairs(data.raw.technology[tech].effects) do
            if effect and effect.type == "ammo-damage" then
                effect.modifier = modifiers.ammo or effect.modifier
            elseif effect and effect.turret_id == "gun-turret" then
                effect.modifier = modifiers.gun_turret or effect.modifier
            elseif effect and effect.turret_id == "spice-rack-longrange-turret" then
                effect.modifier = modifiers.longrange_turret or effect.modifier
            end
        end
    end

end

------ << Gun turret
