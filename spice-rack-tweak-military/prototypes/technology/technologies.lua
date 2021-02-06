local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Long Range Turret
if settingsutil.get_startup_setting("longrange-turret") then
    
    local longrange_turret_tech = util.table.deepcopy(data.raw.technology['gun-turret'])

    longrange_turret_tech.name = "spice-rack-longrange-turret-research"
    longrange_turret_tech.effects = 
            {
                {
                    type = "unlock-recipe",
                    recipe = "spice-rack-longrange-turret"
                },
                {
                    type = "turret-attack",
                    turret_id = "spice-rack-longrange-turret",
                    modifier = 0.25
                }
            }

    longrange_turret_tech.prerequisites = {"gun-turret", "military-3", "concrete"}
    longrange_turret_tech.unit =
            {
                count = 300,
                ingredients = { 
                    {"automation-science-pack", 1}, 
                    {"logistic-science-pack", 1}, 
                    {"military-science-pack", 1} },
                time = 30
            }
            
    longrange_turret_tech.order = "a-j-b"

    data:extend({longrange_turret_tech})

    table.insert(data.raw.technology['physical-projectile-damage-3'].effects, 
    {
        type = "turret-attack",
        turret_id = "spice-rack-longrange-turret",
        modifier = 0.2
    })
    table.insert(data.raw.technology['physical-projectile-damage-4'].effects, 
    {
        type = "turret-attack",
        turret_id = "spice-rack-longrange-turret",
        modifier = 0.25
    })
    table.insert(data.raw.technology['physical-projectile-damage-5'].effects, 
    {
        type = "turret-attack",
        turret_id = "spice-rack-longrange-turret",
        modifier = 0.3
    })

    table.insert(data.raw.technology['physical-projectile-damage-6'].effects, 
    {
        type = "turret-attack",
        turret_id = "spice-rack-longrange-turret",
        modifier = 0.45
    })

    table.insert(data.raw.technology['physical-projectile-damage-7'].effects, 
    {
        type = "turret-attack",
        turret_id = "spice-rack-longrange-turret",
        modifier = 0.75
    })
end
------ << Long Range Turret