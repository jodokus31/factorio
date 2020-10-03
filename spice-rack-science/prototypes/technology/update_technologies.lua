local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Utility Science
if settingsutil.get_startup_setting("utility-science-pack") then
    tableutil.add(data.raw.technology['utility-science-pack'].prerequisites, "uranium-processing")
end 
------ << Utility Science

------ >> Rocket Silo
if settingsutil.get_startup_setting("rocket-silo") then
    tableutil.add(data.raw.technology['rocket-silo'].unit.ingredients, {"military-science-pack", 1})
end
------ << Rocket Silo