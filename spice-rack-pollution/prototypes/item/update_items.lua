local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Effectivity Modules
if settingsutil.get_startup_setting("effectivity-modules-rebalance") then
    -- {
    --     name = "effectivity-module",
    --     effect = { consumption = {bonus = -0.3}},
    -- }

    data.raw.module['effectivity-module'].effect = {consumption = {bonus = -0.25}, pollution = {bonus = -0.15}}

    -- {
    --     name = "effectivity-module-2",
    --     effect = { consumption = {bonus = -0.4}},
    -- }

    data.raw.module['effectivity-module-2'].effect = {consumption = {bonus = -0.55}, pollution = {bonus = -0.4}}

    -- {
    --     name = "effectivity-module-3",
    --     effect = { consumption = {bonus = -0.5}},
    -- }

    data.raw.module['effectivity-module-3'].effect = {consumption = {bonus = -2}, pollution = {bonus = -1.2}}
end
------ << Effectivity Modules