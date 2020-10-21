local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Flamethrower
if settingsutil.get_startup_setting("flamethrower-change") then
    -- type = "fluid-turret"
    -- name = "flamethrower-turret",
    -- attack_parameters =
    --     {
    --     fluids =
    --       {
    --         {type = "crude-oil"},
    --         {type = "heavy-oil", damage_modifier = 1.05},
    --         {type = "light-oil", damage_modifier = 1.1}
    --       },
    -- fluid_consumption = 0.2

    for _, fluid in pairs(data.raw['fluid-turret']['flamethrower-turret'].attack_parameters.fluids) do
        if fluid then
            if fluid.type == "crude-oil" then
                fluid.damage_modifier = 0.5
            else if fluid.type == "heavy-oil" then
                fluid.damage_modifier = 0.7
            else if fluid.type == "light-oil" then
                fluid.damage_modifier = 1
            end end end
        end
    end

    data.raw['fluid-turret']['flamethrower-turret'].attack_parameters.fluid_consumption = 0.6

    -- type = "stream",
    -- name = "flamethrower-fire-stream",

    local action_index, action = tableutil.find(
        data.raw.stream['flamethrower-fire-stream'].action,
        function (a) return a and a.type == "area" end)

    if action then
        
        action.radius = 1.8  -- original 2.5 

        local effect_index, effect = tableutil.find(
            action.action_delivery.target_effects,
            function (e) return e and e.type == "damage" end)

        if effect then
            effect.damage.amount = 1.5 -- original 3 == 90
        end
    end

    -- type = "sticker",
    -- name = "fire-sticker",
    -- duration_in_ticks = 30 * 60,
    -- damage_interval = 10,
    -- target_movement_modifier = 0.8,
    -- damage_per_tick = { amount = 10 * 100 / 60, type = "fire" },
    -- spread_fire_entity = "fire-flame-on-tree",
    -- fire_spread_cooldown = 30,
    -- fire_spread_radius = 0.75

    data.raw.sticker['fire-sticker'].duration_in_ticks = 60 * 60
    data.raw.sticker['fire-sticker'].damage_per_tick = { amount = 10 * 10 / 60, type = "fire" }

    -- type = "fire",
    -- name = "fire-flame",
    -- damage_per_tick = {amount = 13 / 60, type = "fire"},

    data.raw.fire['fire-flame'].damage_per_tick = {amount = 8 / 60, type = "fire"}
end
------ << Flamethrower

------ >> Laser Turret
if settingsutil.get_startup_setting("laser-change") then

    -- type = "electric-turret",
    -- name = "laser-turret",

    -- energy_source =
    --     {
    --       ...
    --       drain = "24kW",
    --       ...
    --     },
    data.raw['electric-turret']['laser-turret'].energy_source.drain = "60kW"
    
end
------ << Laser Turret

------ >> Grenade
-- if settingsutil.get_startup_setting("grenade-change") then

    -- local action_index, action = tableutil.find(
    --     data.raw['projectile']['grenade'].action,
    --     function (a) return a and a.type == "area" end)

    -- if action then
        
    --     action.radius = 7.5

    --     -- local effect_index, effect = tableutil.find(
    --     --     action.action_delivery.target_effects,
    --     --     function (e) return e and e.type == "damage" end)

    --     -- if effect then
    --     --     effect.damage.amount = 40
    --     -- end
    -- end

    -- data.raw['capsule']['grenade'].capsule_action.attack_parameters.range = 16
-- end
------ << Grenade

------ >> Landmine
-- if settingsutil.get_startup_setting("landmine-change") then

-- end
------ << Landmine

------ >> Spawner
if settingsutil.get_startup_setting("spawner-change") then

    -- type = "unit-spawner",
    -- name = "biter-spawner",
    -- max_health = 350,
    -- healing_per_tick = 0.02,

    -- type = "unit-spawner",
    -- name = "spitter-spawner",
    -- max_health = 350,
    -- healing_per_tick = 0.02,

    data.raw['unit-spawner']['biter-spawner'].max_health = 600
    data.raw['unit-spawner']['biter-spawner'].healing_per_tick = 0.1
    tableutil.add(data.raw['unit-spawner']['biter-spawner'].resistances, 
        {
            type = "laser",
            decrease = 0,
            percent = 50
        })
    tableutil.add(data.raw['unit-spawner']['biter-spawner'].resistances, 
        {
            type = "impact",
            decrease = 0,
            percent = 50
        })

    data.raw['unit-spawner']['spitter-spawner'].max_health = 600
    data.raw['unit-spawner']['spitter-spawner'].healing_per_tick = 0.1
    tableutil.add(data.raw['unit-spawner']['spitter-spawner'].resistances, 
        {
            type = "laser",
            decrease = 0,
            percent = 50
        })
    tableutil.add(data.raw['unit-spawner']['spitter-spawner'].resistances, 
        {
            type = "impact",
            decrease = 0,
            percent = 50
        })

end
------ << Spawner

------ >> Tank
if settingsutil.get_startup_setting("tank-change") then
    -- type = "car",
    -- name = "tank",
    -- max_health = 2000,
    -- rotation_speed = 0.0035,
    -- weight = 20000,
    -- consumption = "600kW",
    -- braking_power = "400kW",
    data.raw['car']['tank'].max_health = 3000
    data.raw['car']['tank'].rotation_speed = 0.004
    data.raw['car']['tank'].weight = 25000
    data.raw['car']['tank'].consumption = "900kW"
    data.raw['car']['tank'].braking_power = "600kW"

end
------ << Tank


------ >> Car
if settingsutil.get_startup_setting("car-change") then
    -- type = "car",
    -- name = "car",
    -- max_health = 450,
    -- resistances =
    -- {
    --   {
    --     type = "fire",
    --     percent = 50
    --   },
    --   {
    --     type = "impact",
    --     percent = 30,
    --     decrease = 50
    --   },
    --   {
    --     type = "acid",
    --     percent = 20
    --   },
    -- },
    data.raw['car']['car'].max_health = 600
    tableutil.add(data.raw['car']['car'].resistances,
        {
            type = "physical",
            decrease = 3,
            percent = 30
        })
end
------ << Car

------ >> Repair pack
-- if settingsutil.get_startup_setting("repair-pack-change") then

--     -- type = "repair-tool",
--     -- name = "repair-pack",
--     -- speed = 2,
--     -- durability = 300,
--     -- stack_size = 100

--     data.raw['repair-tool']['repair-pack'].speed = 2
--     data.raw['repair-tool']['repair-pack'].durability = 500
--     data.raw['repair-tool']['repair-pack'].stack_size = 50
-- end
------ << Repair pack

------ >> Shotgun
if settingsutil.get_startup_setting("shotgun-change") then
    -- type = "ammo",
    -- name = "shotgun-shell",
    -- ammo_type =
    -- {
    --   category = "shotgun-shell",
    --   target_type = "direction",
    --   clamp_position = true,
    --   action =
    --   {
    --     {
    --       type = "direct",
    --       action_delivery =
    --       {
    --         type = "instant",
    --         source_effects =
    --         {
    --           {
    --             type = "create-explosion",
    --             entity_name = "explosion-gunshot"
    --           }
    --         }
    --       }
    --     },
    --     {
    --       type = "direct",
    --       repeat_count = 12,
    --       action_delivery =
    --       {
    --         type = "projectile",
    --         projectile = "shotgun-pellet",
    --         starting_speed = 1,
    --         starting_speed_deviation = 0.1,
    --         direction_deviation = 0.3,
    --         range_deviation = 0.3,
    --         max_range = 15
    --       }
    --     }
    --   }
    -- },

    -- type = "projectile",
    -- name = "shotgun-pellet",
    -- action =
    -- {
    --   type = "direct",
    --   action_delivery =
    --   {
    --     type = "instant",
    --     target_effects =
    --     {
    --       type = "damage",
    --       damage = {amount = 5, type = "physical"}
    --     }
    --   }
    -- },

    local _, shell_action = tableutil.find(data.raw['ammo']['shotgun-shell'].ammo_type.action,
        function (a) 
            return a and a.type == "direct" and 
                    a.action_delivery and a.action_delivery.type == "projectile" 
            end
        )
    -- 60 = 12 * 5 damage
    if shell_action then
        -- shell_action.repeat_count = 12
        shell_action.action_delivery.direction_deviation = 0.6
    end

    tableutil.add(data.raw['ammo']['shotgun-shell'].ammo_type.action,
        {
            type = "area",
            radius = 1.4,
            force = "enemy",
            action_delivery =
            {
                type = "instant",
                target_effects =
                {
                    {
                        type = "damage",
                        damage = {amount = 8, type = "physical"}
                    },
                    {
                        type = "push-back",
                        distance = 1
                    },
                    {
                        type = "create-sticker",
                        sticker = "spice-rack-short-stun-sticker"
                    }
                }
            }
        }
    )
    -- data.raw['projectile']['shotgun-pellet'].action.action_delivery.target_effects.damage.amount = 5

    local _, piercing_shell_action = tableutil.find(data.raw['ammo']['piercing-shotgun-shell'].ammo_type.action,
        function (a) 
            return a and a.type == "direct" and 
                    a.action_delivery and a.action_delivery.type == "projectile" 
            end
        )
    -- 128 = 16 * 8 damage
    if piercing_shell_action then
        -- piercing_shell_action.repeat_count = 18
        piercing_shell_action.action_delivery.direction_deviation = 0.4
    end

    --data.raw['projectile']['piercing-shotgun-pellet'].action.action_delivery.target_effects.damage.amount = 10

    tableutil.add(data.raw['ammo']['piercing-shotgun-shell'].ammo_type.action,
            {
                type = "area",
                radius = 1.4,
                force = "enemy",
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                        {
                            type = "damage",
                            damage = {amount = 16, type = "physical"}
                        },
                        {
                            type = "push-back",
                            distance = 1
                        },
                        {
                            type = "create-sticker",
                            sticker = "spice-rack-short-stun-sticker"
                        }
                    }
                }
            }
        )


    -- type = "gun",
    -- name = "shotgun",
    -- attack_parameters =
    -- {
    --   type = "projectile",
    --   ammo_category = "shotgun-shell",
    --   cooldown = 60,
    --   movement_slow_down_factor = 0.6,
    --   projectile_creation_distance = 1.125,
    --   range = 15,
    --   min_range = 1,
    --   sound = sounds.shotgun
    -- }

    data.raw['gun']['shotgun'].attack_parameters.movement_slow_down_factor = 0.5
    data.raw['gun']['shotgun'].attack_parameters.projectile_creation_distance = 0.3
    data.raw['gun']['shotgun'].attack_parameters.min_range = 0

    -- type = "gun",
    -- name = "combat-shotgun",
    -- attack_parameters =
    -- {
    --   type = "projectile",
    --   ammo_category = "shotgun-shell",
    --   cooldown = 30,
    --   movement_slow_down_factor = 0.5,
    --   damage_modifier = 1.2,
    --   projectile_creation_distance = 1.125,
    --   range = 15,
    --   sound = sounds.shotgun
    -- },

    data.raw['gun']['combat-shotgun'].attack_parameters.movement_slow_down_factor = 0.4
    data.raw['gun']['combat-shotgun'].attack_parameters.projectile_creation_distance = 0.3
    data.raw['gun']['combat-shotgun'].attack_parameters.min_range = 0

end
------ << Shotgun