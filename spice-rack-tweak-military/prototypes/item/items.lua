local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Long Range Turret
if settingsutil.get_startup_setting("longrange-turret") then
    local gunturret_longrange = util.table.deepcopy(data.raw.item['gun-turret'])
    gunturret_longrange.name = "spice-rack-longrange-turret"
    gunturret_longrange.order = "b[turret]-a[spice-rack-longrange-turret]"
    gunturret_longrange.place_result = "spice-rack-longrange-turret"

    data:extend({gunturret_longrange})
end    
------ << Long Range Turret