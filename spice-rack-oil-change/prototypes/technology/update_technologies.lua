local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Oil Change
if settingsutil.get_startup_setting("oil-change") then
    
    local no_chemical_science_techs = {"lubricant", "electric-engine", "lubricant", "robotics", "construction-robotics", "logistic-robotics"}

    for _, techname in pairs (no_chemical_science_techs) do
        tableutil.remove(
            data.raw.technology[techname].unit.ingredients, 
            function (i) return i and i[1] == "chemical-science-pack" end)
    end
    
    data.raw.technology['robotics'].unit.count = 150

    tableutil.remove(
        data.raw.technology['lubricant'].prerequisites,
        function (t) return t == "advanced-oil-processing" end)

    tableutil.add(data.raw.technology['lubricant'].prerequisites, "oil-processing")

    local soildfueleffect = tableutil.remove(
        data.raw.technology['advanced-oil-processing'].effects, 
        function (e) return e and e.recipe == "solid-fuel-from-heavy-oil" end)
    
    tableutil.add(data.raw.technology['oil-processing'].effects, soildfueleffect)

    local crackingeffect = tableutil.remove(
        data.raw.technology['advanced-oil-processing'].effects, 
        function (e) return e and e.recipe == "heavy-oil-cracking" end)

    tableutil.add(data.raw.technology['oil-processing'].effects, crackingeffect)

end
------ << Oil Change
