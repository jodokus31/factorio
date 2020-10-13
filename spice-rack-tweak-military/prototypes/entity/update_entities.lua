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

    data.raw['fluid-turret']['flamethrower-turret'].attack_parameters.fluid_consumption = 0.8

    -- type = "stream",
    -- name = "flamethrower-fire-stream",

    local action_index, action = tableutil.find(
        data.raw.stream['flamethrower-fire-stream'].action,
        function (a) return a and a.type == "area" end)

    if action then
        
        action.radius = 1.8  -- 2.5 

        local effect_index, effect = tableutil.find(
            action.action_delivery.target_effects,
            function (e) return e and e.type == "damage" end)

        if effect then
            effect.damage.amount = 1.5 -- 3 
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
    --       type = "electric",
    --       buffer_capacity = "801kJ",
    --       input_flow_limit = "9600kW",
    --       drain = "24kW",
    --       usage_priority = "primary-input"
    --     },

    -- attack_parameters =
    -- {
    --   type = "beam",
    --   cooldown = 40,
    --   range = 24,
    --   source_direction_count = 64,
    --   source_offset = {0, -3.423489 / 4},
    --   damage_modifier = 2,
    -- }

    data.raw['electric-turret']['laser-turret'].energy_source.drain = "96kW"
    
end
------ << Laser Turret

------ >> Grenade
if settingsutil.get_startup_setting("grenade-change") then

    -- type = "projectile",
    -- name = "grenade",
    -- flags = {"not-on-map"},
    -- acceleration = 0.005,
    -- action =
    -- {
    --     {...
    --     },
    --     {
    --         type = "area",
    --         radius = 6.5,
    --         action_delivery =
    --         {
    --             type = "instant",
    --             target_effects =
    --             {
    --                     {
    --                         type = "damage",
    --                         damage = {amount = 35, type = "explosion"}
    --                     },
    --                     {
    --                         type = "create-entity",
    --                         entity_name = "explosion"
    --                     }
    --             }
    --         }
    --     }
    -- },

    local action_index, action = tableutil.find(
        data.raw['projectile']['grenade'].action,
        function (a) return a and a.type == "area" end)

    if action then
        
        local effect_index, effect = tableutil.find(
            action.action_delivery.target_effects,
            function (e) return e and e.type == "damage" end)

        if effect then
            effect.damage.amount = 40
        end
    end


end
------ << Grenade

------ >> Landmine
-- if settingsutil.get_startup_setting("landmine-change") then

    -- type = "land-mine",
    -- name = "land-mine",
    -- action =
    -- {
    --   type = "direct",
    --   action_delivery =
    --   {
    --     type = "instant",
    --     source_effects =
    --     {
    --       {
    --         type = "nested-result",
    --         affects_target = true,
    --         action =
    --         {
    --           type = "area",
    --           radius = 6,
    --           force = "enemy",
    --           action_delivery =
    --           {
    --             type = "instant",
    --             target_effects =
    --             {
    --               {
    --                 type = "damage",
    --                 damage = { amount = 250, type = "explosion"}
    --               },
    --               {
    --                 type = "create-sticker",
    --                 sticker = "stun-sticker"
    --               }
    --             }
    --           }
    --         }
    --       },
    --       {
    --         type = "create-entity",
    --         entity_name = "explosion"
    --       },
    --       {
    --         type = "damage",
    --         damage = { amount = 1000, type = "explosion"}
    --       },
    --     }
    --   }
    -- }
-- end
------ << Landmine

------ >> Spawner
if settingsutil.get_startup_setting("spawner-change") then

    -- type = "unit-spawner",
    -- name = "biter-spawner",
    -- max_health = 350,
    -- resistances =
    --     {
    --       {
    --         type = "physical",
    --         decrease = 2,
    --         percent = 15
    --       },
    --       {
    --         type = "explosion",
    --         decrease = 5,
    --         percent = 15
    --       },
    --       {
    --         type = "fire",
    --         decrease = 3,
    --         percent = 60
    --       }
    --     },
    -- healing_per_tick = 0.02,


    -- type = "unit-spawner",
    -- name = "spitter-spawner",
    -- max_health = 350,
    -- resistances =
    -- {
    --   {
    --     type = "physical",
    --     decrease = 2,
    --     percent = 15
    --   },
    --   {
    --     type = "explosion",
    --     decrease = 5,
    --     percent = 15
    --   },
    --   {
    --     type = "fire",
    --     decrease = 3,
    --     percent = 60
    --   }
    -- }
    -- healing_per_tick = 0.02,

    data.raw['unit-spawner']['biter-spawner'].max_health = 500
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

    data.raw['unit-spawner']['spitter-spawner'].max_health = 500
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
    data.raw['car']['tank'].consumption = "1000kW"
    data.raw['car']['tank'].braking_power = "650kW"

    -- type = "repair-tool",
    -- name = "repair-pack",
    -- speed = 2,
    -- durability = 300,
    -- stack_size = 100

    data.raw['repair-tool']['repair-pack'].speed = 3
    data.raw['repair-tool']['repair-pack'].durability = 500
    data.raw['repair-tool']['repair-pack'].stack_size = 50
end
------ << Tank
