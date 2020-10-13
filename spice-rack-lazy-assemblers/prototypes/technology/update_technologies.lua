local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Lazy Assemblers
if settingsutil.get_startup_setting("crafting-limitation-mode") ~= "disabled" then
    tableutil.add(data.raw.technology['productivity-module-3'].prerequisites, "automation-3", true)
    tableutil.add(data.raw.technology['speed-module-3'].prerequisites, "automation-3", true)
    tableutil.add(data.raw.technology['effectivity-module-3'].prerequisites, "automation-3", true)
    tableutil.add(data.raw.technology['rocket-control-unit'].prerequisites, "automation-3", true)

    -- tableutil.add(data.raw.technology['rocket-control-unit'].unit.ingredients, {"production-science-pack", 1})
end
------ << Lazy Assemblers