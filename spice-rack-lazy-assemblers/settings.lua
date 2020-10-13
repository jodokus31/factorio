data:extend(
{
    {
        type = "string-setting",
        name = "spice-rack-crafting-limitation-mode",
        order = "a",
        setting_type = "startup",
        default_value = "assembler only",
        allowed_values = {"disabled", "assembler only", "assembler and character"},
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
