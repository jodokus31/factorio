data:extend(
{
    {
        type = "string-setting",
        name = "spice-rack-crafting-limitation-mode",
        order = "a",
        setting_type = "startup",
        default_value = "assembler",
        allowed_values = {"disabled", "assembler", "assembler-and-character"},
        per_user = false,
    },
    {
        type = "bool-setting",
        name = "spice-rack-classic-lazy-bastard",
        order = "b",
        setting_type = "startup",
        default_value = false,
        per_user = false,
    },
    {
        type = "bool-setting",
        name = "spice-rack-lazy-bastard-marathon",
        order = "c",
        setting_type = "startup",
        default_value = false,
        per_user = false,
    },
})
