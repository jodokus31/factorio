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
            elseif fluid.type == "heavy-oil" then
                fluid.damage_modifier = 0.7
            elseif fluid.type == "light-oil" then
                fluid.damage_modifier = 1
            end
        end
    end

    data.raw['fluid-turret']['flamethrower-turret'].attack_parameters.fluid_consumption = 0.6 --> 9/s

    -- type = "stream",
    -- name = "flamethrower-fire-stream",

    do
        local action_index, action = tableutil.find(
            data.raw.stream['flamethrower-fire-stream'].action,
            function (a) return a and a.type == "area" end)

        if action then
            
            action.radius = 1.25  -- original 2.5 

            local effect_index, effect = tableutil.find(
                action.action_delivery.target_effects,
                function (e) return e and e.type == "damage" end)

            if effect then
                effect.damage.amount = 0.75 -- original 3 == 90
            end
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

    -- longer, but lot less damage
    data.raw.sticker['fire-sticker'].duration_in_ticks = 60 * 60
    data.raw.sticker['fire-sticker'].damage_per_tick = { amount = 10 * 10 / 60, type = "fire" }
    data.raw.sticker['fire-sticker'].target_movement_modifier = 0.7

    -- type = "fire",
    -- name = "fire-flame",
    -- damage_per_tick = {amount = 13 / 60, type = "fire"},

    data.raw.fire['fire-flame'].damage_per_tick = {amount = 5 / 60, type = "fire"}
    data.raw.fire['fire-flame'].maximum_damage_multiplier = 3
    data.raw.fire['fire-flame'].damage_multiplier_increase_per_added_fuel = 0.3


    -- type = "stream",
    -- name = "handheld-flamethrower-fire-stream",
    -- action =
    -- {
    --   {
    --     type = "area",
    --     radius = 2.5,
    --     action_delivery =
    --     {
    --       type = "instant",
    --       target_effects =
    --       {
    --         {
    --           type = "create-sticker",
    --           sticker = "fire-sticker",
    --           show_in_tooltip = true
    --         },
    --         {
    --           type = "damage",
    --           damage = { amount = 2, type = "fire" },
    --           apply_damage_to_trees = false
    --         }
    --       }
    --     }
    --   },

    do
        local action_index, action = tableutil.find(
            data.raw.stream['handheld-flamethrower-fire-stream'].action,
            function (a) return a and a.type == "area" end)

        if action then
            
            action.radius = 1.25  -- original 2.5 

            local effect_index, effect = tableutil.find(
                action.action_delivery.target_effects,
                function (e) return e and e.type == "damage" end)

            if effect then
                effect.damage.amount = 0.5 -- original 2 == 60
            end
        end
    end

    -- type = "construction-robot",
    -- name = "construction-robot",
    -- icon = "__base__/graphics/icons/construction-robot.png",
    -- icon_size = 64, icon_mipmaps = 4,
    -- flags = {"placeable-player", "player-creation", "placeable-off-grid", "not-on-map"},
    -- minable = {mining_time = 0.1, result = "construction-robot"},
    -- resistances =
    -- {
    --   {
    --     type = "fire",
    --     percent = 85
    --   }
    -- },

    do 
        data.raw["construction-robot"]["construction-robot"].hide_resistances = false
        local _, fire_resistance = tableutil.find(
            data.raw["construction-robot"]["construction-robot"].resistances,
            function (r) return r and r.type == "fire" end)
        
        if fire_resistance then
            fire_resistance.percent = 100
        end
    end

    do 
        local pipes = {
            data.raw["pipe"]["pipe"],
            data.raw["pipe-to-ground"]["pipe-to-ground"]
        }

        for _, pipe in pairs(pipes) do 
            
            pipe.hide_resistances = false
            local _, fire_resistance = tableutil.find(
                pipe.resistances,
                function (r) return r and r.type == "fire" end)
            
            if fire_resistance then
                fire_resistance.percent = 100
            end

            tableutil.add(pipe.resistances,
                {
                    type = "acid",
                    percent = 80,
                })
        end
    end
end
------ << Flamethrower

------ >> Laser Turret
if settingsutil.get_startup_setting("laser-turret-change") then

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

-- ------ >> Gun Turret health
-- if settingsutil.get_startup_setting("gun-turret-health-change") then

--     -- type = "ammo-turret",
--     -- name = "gun-turret",
    
--     -- max_health = 400,
    
--     data.raw['ammo-turret']['gun-turret'].max_health = 600
    
-- end
-- ------ << Gun Turret health


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
if settingsutil.get_startup_setting("landmine-change") then
--   {
--     type = "land-mine",
--     name = "land-mine",
    
--     trigger_radius = 2.5,
--     ammo_category = "landmine",
--     action =
--     {
--       type = "direct",
--       action_delivery =
--       {
--         type = "instant",
--         source_effects =
--         {
--           {
--             type = "nested-result",
--             affects_target = true,
--             action =
--             {
--               type = "area",
--               radius = 6,
--               force = "enemy",
--               action_delivery =
--               {
--                 type = "instant",
--                 target_effects =
--                 {
--                   {
--                     type = "damage",
--                     damage = { amount = 250, type = "explosion"}
--                   },
--                   {
--                     type = "create-sticker",
--                     sticker = "stun-sticker"
--                   }
--                 }
--               }
--             }
--           },
--           {
--             type = "create-entity",
--             entity_name = "explosion"
--           },
--           {
--             type = "damage",
--             damage = { amount = 1000, type = "explosion"}
--           }
--         }
--       }
--     }
--   },
    -- arming timout: default 2*60 -> 2 sec.
    data.raw['land-mine']['land-mine'].timeout = 5*60 -- 5 sec.
    data.raw['land-mine']['land-mine'].collision_box = {{-0.35,-0.35}, {0.35, 0.35}}
    data.raw['land-mine']['land-mine'].resistances =
    {
        {
            type = "fire",
            percent = 100
        }
    }
    data.raw['land-mine']['land-mine'].trigger_radius = 1.5
    
    local damage_effect_index, damage_effect = tableutil.find(
        data.raw['land-mine']['land-mine'].action.action_delivery.source_effects,
        function (a) return a and a.type == "damage" end)

    if damage_effect_index >= 0 then
        -- i don't know, what this damage does, but i reduce it anyway
        damage_effect.damage.amount = 300
    end

    local nested_effect_index, nested_effect = tableutil.find(
        data.raw['land-mine']['land-mine'].action.action_delivery.source_effects,
        function (a) return a and a.type == "nested-result" end)

    if nested_effect_index >= 0 then

        nested_effect.action.radius = 5

        local area_damage_effect_index, area_damage_effect = tableutil.find(
            nested_effect.action.action_delivery.target_effects,
            function (a) return a and a.type == "damage" end)
        
        if area_damage_effect_index >= 0 then
            area_damage_effect.damage.amount = 75
        end

        local stun_effect_index, stun_effect_effect = tableutil.find(
            nested_effect.action.action_delivery.target_effects,
            function (a) return a and a.type == "create-sticker" end)
        
        if stun_effect_index >= 0 then
            stun_effect_effect.sticker = "spice-rack-landmine-stun-sticker"
        end

        table.insert(nested_effect.action.action_delivery.target_effects,
                {
                    type = "create-sticker",
                    sticker = "spice-rack-landmine-slowdown-sticker"
                })
    end
end
------ << Landmine

------ >> Tank
if settingsutil.get_startup_setting("tank-change") then
    -- type = "car",
    -- name = "tank",
    -- max_health = 2000,
    -- rotation_speed = 0.0035,
    -- weight = 20000,
    -- consumption = "600kW",
    -- braking_power = "400kW",
    data.raw['car']['tank'].max_health = 4000
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
        },
        {
            type = "acid",
            decrease = 0,
            percent = 20
        }
    )
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

------ << Biters
if settingsutil.get_startup_setting("biter-change") then
    -- type = "unit",
    -- name = "medium-biter",
    -- max_health = 75,
    -- resistances =
    -- {
    --   {
    --     type = "physical",
    --     decrease = 4,
    --     percent = 10
    --   },
    --   {
    --     type = "explosion",
    --     percent = 10
    --   }
    -- },


    -- type = "unit",
    -- name = "big-biter",
    -- max_health = 375,
    -- resistances =
    -- {
    --   {
    --     type = "physical",
    --     decrease = 8,
    --     percent = 10
    --   },
    --   {
    --     type = "explosion",
    --     percent = 10
    --   }
    -- }

    tableutil.add(data.raw['unit']['big-biter'].resistances, 
        {
            type = "laser",
            decrease = 5,
            percent = 20
        })
    
    -- do
    --     local _, resistance = tableutil.find(data.raw['unit']['big-biter'].resistances, 
    --         function (r) return r and r.type == "explosion" end)
    --     if resistance then
    --         resistance.decrease = 5
    --         resistance.percent = 15
    --     end
    -- end

    -- type = "unit",
    -- name = "behemoth-biter",
    -- max_health = 3000,
    -- resistances =
    -- {
    --   {
    --     type = "physical",
    --     decrease = 12,
    --     percent = 10
    --   },
    --   {
    --     type = "explosion",
    --     decrease = 12,
    --     percent = 10
    --   }
    -- }
    tableutil.add(data.raw['unit']['behemoth-biter'].resistances, 
        {
            type = "laser",
            decrease = 10,
            percent = 40
        })
    
    -- do
    --     local _, resistance = tableutil.find(data.raw['unit']['behemoth-biter'].resistances, 
    --         function (r) return r and r.type == "explosion" end)
    --     if resistance then
    --         resistance.decrease = 15
    --         resistance.percent = 20
    --     end
    -- end

    -- type = "unit",
    -- name = "medium-spitter",
    -- max_health = 50,
    -- resistances =
    -- {
    --   {
    --     type = "explosion",
    --     percent = 10
    --   }
    -- },

    -- type = "unit",
    -- name = "big-spitter",
    -- max_health = 200,
    -- resistances =
    -- {
    --   {
    --     type = "explosion",
    --     percent = 15
    --   }
    -- },

    -- do
    --     local _, resistance = tableutil.find(data.raw['unit']['big-spitter'].resistances, 
    --         function (r) return r and r.type == "explosion" end)
    --     if resistance then
    --         resistance.decrease = 15
    --         resistance.percent = 20
    --     end
    -- end

    -- type = "unit",
    -- name = "behemoth-spitter",

    -- max_health = 1500,
    -- resistances =
    -- {
    --   {
    --     type = "explosion",
    --     percent = 30
    --   }
    -- },

    -- do
    --     local _, resistance = tableutil.find(data.raw['unit']['behemoth-spitter'].resistances, 
    --         function (r) return r and r.type == "explosion" end)
    --     if resistance then
    --         resistance.decrease = 15
    --         resistance.percent = 20
    --     end
    -- end

end
------ >> Biters

------ >> Rock change
if settingsutil.get_startup_setting("rock-change") then

    -- name = "rock-huge",
    -- type = "simple-entity",
    -- ...
    -- minable =
    -- {
    --   mining_particle = "stone-particle",
    --   mining_time = 3,
    --   results = {{name = "stone", amount_min = 24, amount_max = 50}, {name = "coal", amount_min = 24, amount_max = 50}},
    -- },

    data.raw['simple-entity']['rock-huge'].minable.results = 
        {
            { name = "stone", amount_min = 37, amount_max = 37}, 
            { name = "coal",  amount_min = 37, amount_max = 37},
        }
    
end
------ << Rock change