local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Lab
if settingsutil.get_startup_setting("lab-change") then
    -- type = "lab",
    -- name = "lab",
    -- energy_usage = "60kW",

    data.raw.lab['lab'].energy_usage = "180kW"
end
------ << Lab
