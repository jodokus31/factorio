local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Long Range Turret
if settingsutil.get_startup_setting("longrange-turret") then
    local gunturret_longrange = util.table.deepcopy(data.raw['ammo-turret']['gun-turret'])
    gunturret_longrange.name = "spice-rack-longrange-turret"
    gunturret_longrange.minable = {mining_time = 0.5, result = "spice-rack-longrange-turret"}
    gunturret_longrange.max_health = 500
    gunturret_longrange.automated_ammo_count = 5
    gunturret_longrange.attack_parameters.range = 24
    --gunturret_longrange.attacking_speed = 0.1
    gunturret_longrange.attack_parameters.cooldown = 15
    --gunturret_longrange.attack_parameters.damage_modifier = 1.5

    local function changetint(layer, color)
        layer.apply_runtime_tint = false
        layer.tint = color

        layer.hr_version.apply_runtime_tint = false
        layer.hr_version.tint = color
    end
    local green = {r=0.5, g=1, b=0.5, a=1}

    changetint(gunturret_longrange.folded_animation.layers[2], green)
    changetint(gunturret_longrange.preparing_animation.layers[2], green)
    changetint(gunturret_longrange.prepared_animation.layers[2], green)
    changetint(gunturret_longrange.attacking_animation.layers[2], green)
    changetint(gunturret_longrange.folding_animation.layers[2], green)


    data:extend({gunturret_longrange})
end   

------ << Long Range Turret

------ >> Shotgun
if settingsutil.get_startup_setting("shotgun-change") then
    data:extend({
        {
            type = "sticker",
            name = "spice-rack-short-stun-sticker",
            flags = {"not-on-map"},
            duration_in_ticks = 0.5*60,
            target_movement_modifier = 0
        },
    })
end
------ << Shotgun

------ >> Landmine
if settingsutil.get_startup_setting("landmine-change") then
    data:extend({
        {
            type = "sticker",
            name = "spice-rack-middle-stun-sticker",
            flags = {"not-on-map"},
            duration_in_ticks = 1.5*60,
            target_movement_modifier = 0
        },
    })
end
------ << Landmine