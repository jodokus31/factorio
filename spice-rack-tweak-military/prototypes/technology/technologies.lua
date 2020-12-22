local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Long Range Turret
if settingsutil.get_startup_setting("longrange-turret") then
    data:extend(
    {
        {
            type = "technology",
            name = "spice-rack-longrange-turret-research",
            icon_size = 128,
            icon = "__base__/graphics/technology/gun-turret.png",
            effects =
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
            },
            prerequisites = {"gun-turret", "military-3", "concrete"},
            unit =
            {
                count = 300,
                ingredients = { 
                    {"automation-science-pack", 1}, 
                    {"logistic-science-pack", 1}, 
                    {"military-science-pack", 1} },
                time = 30
            },
            order = "a-j-b"
        }
    })

    table.insert(data.raw.technology['physical-projectile-damage-3'].effects, 
    {
        type = "turret-attack",
        turret_id = "spice-rack-longrange-turret",
        modifier = 0.3
    })
    table.insert(data.raw.technology['physical-projectile-damage-4'].effects, 
    {
        type = "turret-attack",
        turret_id = "spice-rack-longrange-turret",
        modifier = 0.35
    })
    table.insert(data.raw.technology['physical-projectile-damage-5'].effects, 
    {
        type = "turret-attack",
        turret_id = "spice-rack-longrange-turret",
        modifier = 0.4
    })

    table.insert(data.raw.technology['physical-projectile-damage-6'].effects, 
    {
        type = "turret-attack",
        turret_id = "spice-rack-longrange-turret",
        modifier = 0.5
    })

    table.insert(data.raw.technology['physical-projectile-damage-7'].effects, 
    {
        type = "turret-attack",
        turret_id = "spice-rack-longrange-turret",
        modifier = 0.75
    })
end
------ << Long Range Turret