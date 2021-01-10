local SettingsUtil = {}

function SettingsUtil.get_startup_setting(name)
    return settings.startup["spice-rack-" .. name].value
end

function SettingsUtil.get_global_setting(name)
    return settings.global["spice-rack-" .. name].value
end

function SettingsUtil.get_runtime_setting(player_index, name)
    return settings.get_player_settings(player_index)["spice-rack-" .. name].value
end

return SettingsUtil
