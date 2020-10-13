data:extend(
{
    {
        type = "string-setting",
        name = "spice-rack-oil-change",
        order = "a",
        setting_type = "startup",
        default_value = "basic oil and research",
        allowed_values = {"disabled", "basic oil only", "basic oil and research"},
        per_user = false,
    },
    {
        type = "bool-setting",
        name = "spice-rack-oil-change-solid-fuel",
        order = "b",
        setting_type = "startup",
        default_value = true,
        per_user = false,
    },
})
