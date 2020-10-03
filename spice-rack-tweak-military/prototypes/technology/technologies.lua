local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Long Range Turret
if settingsutil.get_startup_setting("longrange-turret") then
    data:extend(
    {
        {
            type = "technology",
            name = "turretslongrange",
            icon_size = 128,
            icon = "__base__/graphics/technology/turrets.png",
            effects =
            {
                {
                    type = "unlock-recipe",
                    recipe = "gun-turret-long-range"
                },
                {
                    type = "turret-attack",
                    turret_id = "gun-turret-long-range",
                    modifier = 1.2
                }
            },
            prerequisites = {"turrets", "chemical-science-pack", "military-3"},
            unit =
            {
                count = 150,
                ingredients = { 
                    {"automation-science-pack", 1}, 
                    {"logistic-science-pack", 1}, 
                    {"chemical-science-pack", 1}, 
                    {"military-science-pack", 1} },
                time = 30
            },
            order = "a-j-b"
        }
    })

    table.insert(data.raw.technology['physical-projectile-damage-5'].effects, 
    {
        type = "turret-attack",
        turret_id = "gun-turret-long-range",
        modifier = 0.2
    })

    table.insert(data.raw.technology['physical-projectile-damage-6'].effects, 
    {
        type = "turret-attack",
        turret_id = "gun-turret-long-range",
        modifier = 0.4
    })

    table.insert(data.raw.technology['physical-projectile-damage-7'].effects, 
    {
        type = "turret-attack",
        turret_id = "gun-turret-long-range",
        modifier = 0.7
    })
end
------ << Long Range Turret