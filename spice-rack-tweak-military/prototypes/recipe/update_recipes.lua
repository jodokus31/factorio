local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Landmine

if settingsutil.get_startup_setting("landmine-change") then
    -- {
    --     type = "recipe",
    --     name = "land-mine",
    --     ingredients =
    --     {
    --       {"steel-plate", 1},
    --       {"explosives", 2}
    --     },
    -- },

    data.raw.recipe['land-mine'].ingredients = { {"steel-plate", 2}, {"explosives", 4} }
end

------ << Landmine

------ >> Tank
if settingsutil.get_startup_setting("tank-change") then
    -- type = "recipe",
    -- name = "tank",
    -- ingredients =
    -- {
    --     {"engine-unit", 32},
    --     {"steel-plate", 50},
    --     {"iron-gear-wheel", 15},
    --     {"advanced-circuit", 10}
    -- },

    data.raw.recipe['tank'].ingredients = {
        {"engine-unit", 96},
        {"steel-plate", 100},
        {"iron-gear-wheel", 100},
        {"advanced-circuit", 50}
    }

end
------ << Tank

------ >> Repair pack
if settingsutil.get_startup_setting("repair-change") then
    -- type = "recipe",
    -- name = "repair-pack",
    -- ingredients =
    -- {
    --   {"electronic-circuit", 2},
    --   {"iron-gear-wheel", 2}
    -- },

    data.raw.recipe['repair-pack'].ingredients = {
        {"electronic-circuit", 5},
        {"iron-gear-wheel", 5}
    }
end
------ << Repair pack