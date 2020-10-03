local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Landmine

if settingsutil.get_startup_setting("change-landmine-cost") then
    -- {
    --     type = "recipe",
    --     name = "land-mine",
    --     ingredients =
    --     {
    --       {"steel-plate", 1},
    --       {"explosives", 2}
    --     },
    -- },

    data.raw.recipe['land-mine'].ingredients = { {"steel-plate", 2}, {"explosives", 5} }
end

------ << Landmine