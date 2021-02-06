data:extend(
{
    {
        type = "string-setting",
        name = "spice-rack-oil-change",
        order = "a",
        setting_type = "startup",
        default_value = "research",
        allowed_values = {"disabled", "basic", "research"},
        per_user = false,
    },
    {
        type = "bool-setting",
        name = "spice-rack-oil-change-steam-cracking",
        order = "b",
        setting_type = "startup",
        default_value = true,
        per_user = false,
    },
    {
        type = "bool-setting",
        name = "spice-rack-oil-change-solid-fuel",
        order = "c",
        setting_type = "startup",
        default_value = true,
        per_user = false,
    },
})
