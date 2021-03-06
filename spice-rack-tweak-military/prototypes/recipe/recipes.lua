local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Long Range Turret
if settingsutil.get_startup_setting("longrange-turret") then
    data:extend(
    {
        {
            type = "recipe",
            name = "spice-rack-longrange-turret",
            enabled = false,
            energy_required = 16,
            ingredients =
            {
                {"steel-plate", 10},
                {"iron-gear-wheel", 20},
                {"copper-plate", 10},
                {"concrete", 24}
            },
            result = "spice-rack-longrange-turret"
        }
    })
end
------ << Long Range Turret