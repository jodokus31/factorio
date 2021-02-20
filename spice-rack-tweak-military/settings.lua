local settings = {}

local bool_settings =
{
    ["spice-rack-longrange-turret"] = true,
    ["spice-rack-flamethrower-change"] = true,
    ["spice-rack-laser-turret-change"] = true,
    ["spice-rack-gun-turret-damage-change"] = true,
    --["spice-rack-gun-turret-health-change"] = true,

    ["spice-rack-landmine-change"] = true,
    ["spice-rack-shotgun-change"] = true,
    ["spice-rack-tank-change"] = true,
    ["spice-rack-car-change"] = true,
    ["spice-rack-repair-pack-change"] = true,

    ["spice-rack-change-military3-research"] = true,
    ["spice-rack-change-military-research"] = true,
    ["spice-rack-change-follower-robot-count"] = true,

    ["spice-rack-spawner-change"] = true,
    ["spice-rack-biter-change"] = true,

    ["spice-rack-rock-change"] = true,
}

local index = 0
for name, default in pairs(bool_settings) do
    table.insert(settings,
        {
            type = "bool-setting",
            name = name,
            order = string.format("a[%03d]", index),
            setting_type = "startup",
            default_value = default,
            per_user = false,
        })
    index = index + 1
end

data:extend(settings)