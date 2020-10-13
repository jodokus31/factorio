local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Utility Science
if settingsutil.get_startup_setting("utility-science-pack") then
    tableutil.add(data.raw.technology['utility-science-pack'].prerequisites, "uranium-processing", true)
end 
------ << Utility Science

------ >> Furnace & Drill Progression
if settingsutil.get_startup_setting("furnace-progression") then
    tableutil.add(data.raw.technology['advanced-material-processing-2'].prerequisites, "concrete", true)
end
------ << Furnace & Drill Progression

------ >> Rocket Silo
if settingsutil.get_startup_setting("rocket-silo") then
    tableutil.add(data.raw.technology['rocket-silo'].prerequisites, "circuit-network", true)
    tableutil.add(data.raw.technology['rocket-silo'].unit.ingredients, {"military-science-pack", 1})
end
------ << Rocket Silo