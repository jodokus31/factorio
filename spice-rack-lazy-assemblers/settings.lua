data:extend(
{
    {
        type = "string-setting",
        name = "spice-rack-crafting-limitation-mode",
        order = "a",
        setting_type = "startup",
        default_value = "assemblers only",
        allowed_values = {"disabled", "assemblers only", "assemblers and player"},
        per_user = false,
    },
    {
        type = "bool-setting",
        name = "spice-rack-runtime-lazy-bastard-marathon",
        order = "a",
        setting_type = "runtime-global",
        default_value = false,
        per_user = false,
    },
})
