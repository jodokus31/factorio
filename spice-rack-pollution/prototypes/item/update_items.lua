local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Effectivity Modules
if settingsutil.get_startup_setting("effectivity-modules-rebalance") then
    -- {
    --     name = "effectivity-module",
    --     effect = { consumption = {bonus = -0.3}},
    -- }

    --data.raw.module['effectivity-module'].effect = {consumption = {bonus = -0.30}, pollution = {bonus = 0.25}}
    data.raw.module['effectivity-module'].effect = {consumption = {bonus = -0.20}}
    -- {
    --     name = "effectivity-module-2",
    --     effect = { consumption = {bonus = -0.4}},
    -- }

    --data.raw.module['effectivity-module-2'].effect = {consumption = {bonus = -0.80}, pollution = {bonus = 0.20}}
    data.raw.module['effectivity-module-2'].effect = {consumption = {bonus = -0.60}}
    -- {
    --     name = "effectivity-module-3",
    --     effect = { consumption = {bonus = -0.5}},
    -- }

    --data.raw.module['effectivity-module-3'].effect = {consumption = {bonus = -2.00}, pollution = {bonus = 0.80}}
    data.raw.module['effectivity-module-2'].effect = {consumption = {bonus = -2.00}}
end
------ << Effectivity Modules