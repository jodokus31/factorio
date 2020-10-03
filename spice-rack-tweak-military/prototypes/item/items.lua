local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Long Range Turret
if settingsutil.get_startup_setting("longrange-turret") then
    local gunturret_longrange = util.table.deepcopy(data.raw.item['gun-turret'])
    gunturret_longrange.name = "gun-turret-long-range"
    gunturret_longrange.order = "b[turret]-b[gun-turret-long-range]"
    gunturret_longrange.place_result = "gun-turret-long-range"

    data:extend({gunturret_longrange})
end    
------ << Long Range Turret