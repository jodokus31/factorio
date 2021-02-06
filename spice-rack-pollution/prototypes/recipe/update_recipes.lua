local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Effectivity Modules

if settingsutil.get_startup_setting("effectivity-modules-change") then
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
