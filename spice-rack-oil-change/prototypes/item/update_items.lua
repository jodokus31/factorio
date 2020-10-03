local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Oil Change

if settingsutil.get_startup_setting("oil-change-solid-fuel") then
    -- type = "item",
    -- name = "solid-fuel",
    -- fuel_acceleration_multiplier = 1.2,

    data.raw.item['solid-fuel'].fuel_acceleration_multiplier = 1.4
end

------ << Oil Change
