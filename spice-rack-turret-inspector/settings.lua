local settings = {}

table.insert(settings,
    {
        type = "int-setting",
        name = "spice-rack-turret-inspector-debug-mode",
        order = "a",
        setting_type = "runtime-global",
        default_value = 0,
        allowed_values = { 0, 1, 2, 3, 4 }
    })

table.insert(settings,
    {
        type = "bool-setting",
        name = "spice-rack-turret-inspector-show-turret-warnings",
        order = "b",
        setting_type = "runtime-per-user",
        default_value = true,
    })

table.insert(settings,
    {
        type = "int-setting",
        name = "spice-rack-turret-inspector-low-ammo",
        order = "c",
        setting_type = "runtime-per-user",
        default_value = 8,
        minimum_value = 0,
        maximum_value = 200,
    })

data:extend(settings)