local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Flamethrower
if settingsutil.get_startup_setting("flamethrower-debuff") then
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
                fluid.damage_modifier = 0.6
            else if fluid.type == "heavy-oil" then
                fluid.damage_modifier = 0.8
            else if fluid.type == "light-oil" then
                fluid.damage_modifier = 1
            end end end
        end
    end

    data.raw['fluid-turret']['flamethrower-turret'].attack_parameters.fluid_consumption = 0.6
end
------ << Flamethrower

------ >> Laser Turret
if settingsutil.get_startup_setting("laser-drain") then

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

    data.raw['electric-turret']['laser-turret'].energy_source.drain = "96kW"
end
------ << Laser Turret



------ >> Grenade
if settingsutil.get_startup_setting("more-grenade-base-damage") then
    -- type = "projectile",
    --     name = "grenade",
    --     flags = {"not-on-map"},
    --     acceleration = 0.005,
    --     action =
    --     {
    --       {...
    --       },
    --       {
    --         type = "area",
    --         radius = 6.5,
    --         action_delivery =
    --         {
    --           type = "instant",
    --           target_effects =
    --           {
    --             {
    --               type = "damage",
    --               damage = {amount = 35, type = "explosion"}
    --             },
    --             {
    --               type = "create-entity",
    --               entity_name = "explosion"
    --             }
    --           }
    --         }
    --       }
    --     },


    -- local action_index, action = tableutil.find(
    --     data.raw['projectile']['grenade'].action,
    --     function (a) return a and a.type == "area" end)

    -- if action then
        
    --     local effect_index, effect = tableutil.find(
    --         data.raw['projectile']['grenade'].action[action_index].action_delivery.target_effects,
    --         function (e) return e and e.type == "damage" end)

    --     if effect then
    --         data.raw['projectile']['grenade'].action[action_index].action_delivery.target_effects[effect_index].damage.amount = 43.75
    --     end
    -- end

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
-- if settingsutil.get_startup_setting("change-landmine-cost") then
-- end
------ << Landmine