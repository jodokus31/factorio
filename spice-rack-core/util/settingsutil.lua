local SettingsUtil = {}

function SettingsUtil.get_startup_setting(name)
    return settings.startup["spice-rack-" .. name].value
end

function SettingsUtil.get_runtime_setting(name)
    return settings.global["spice-rack-" .. name].value
end

return SettingsUtil