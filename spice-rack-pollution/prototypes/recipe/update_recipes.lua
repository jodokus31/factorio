local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Effectivity Modules

if settingsutil.get_startup_setting("effectivity-modules-rebalance") then
    -- name = "effectivity-module",
    -- ingredients =
    -- {
    --   {"advanced-circuit", 5},
    --   {"electronic-circuit", 5}
    -- },
    --data.raw.recipe['effectivity-module'].ingredients = { {"advanced-circuit", 4}, {"electronic-circuit", 4} }

    -- name = "effectivity-module-2",
    -- ingredients =
    -- {
    --   {"effectivity-module", 4},
    --   {"advanced-circuit", 5},
    --   {"processing-unit", 5}
    -- },
    --data.raw.recipe['effectivity-module-2'].ingredients = { {"effectivity-module", 3}, {"advanced-circuit", 4}, {"processing-unit", 4} }

    -- name = "effectivity-module-3",
    -- ingredients =
    -- {
    --     {"effectivity-module-2", 5},
    --     {"advanced-circuit", 5},
    --     {"processing-unit", 5}
    -- },
    --data.raw.recipe['effectivity-module-3'].ingredients = { {"effectivity-module-2", 5}, {"advanced-circuit", 10}, {"processing-unit", 10} }
end
------ << Effectivity Modules

------ >> Furnace & Drill Progression

if settingsutil.get_startup_setting("furnace-progression") then
    --     name = "stone-furnace",
    --     ingredients = {{"stone", 5}},

    data.raw.recipe['stone-furnace'].ingredients = { {"stone-brick", 4} }

    --     name = "steel-furnace",
    --     ingredients = {{"steel-plate", 6}, {"stone-brick", 10}},

    data.raw.recipe['steel-furnace'].ingredients = { {"stone-furnace", 1}, {"steel-plate", 6}, {"stone-brick", 6} }

    --     name = "electric-furnace",
    --     ingredients = {{"steel-plate", 10}, {"advanced-circuit", 5}, {"stone-brick", 10}},

    data.raw.recipe['electric-furnace'].ingredients = { {"steel-furnace", 1}, {"steel-plate", 4}, {"advanced-circuit", 5} }
end

------ << Furnace & Drill Progression