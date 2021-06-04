local constants = require('script/constants')
local settingsutil = require('__spice-rack-core__/util/settingsutil')

local SettingsWrapper = {}

--runtime
SettingsWrapper.debug_mode = 0

--per user
SettingsWrapper.show_turret_warnings = {}
SettingsWrapper.low_ammo = {}

--startup 
SettingsWrapper.slot_count = 0
SettingsWrapper.interval = 0

SettingsWrapper.logger = nil

function SettingsWrapper.readSettings(include_startup_settings)
    SettingsWrapper.debug_mode = settingsutil.get_global_setting("turret-inspector-debug-mode")
    
    if include_startup_settings then
        -- 23 * 26 = 598 ticks: ~10 sec.
        SettingsWrapper.slot_count = 23 --must be a prime
        SettingsWrapper.interval = 26
    end
end

function SettingsWrapper.readShowTurretWarnings(player_index)
    if not SettingsWrapper.show_turret_warnings[player_index] then
        SettingsWrapper.show_turret_warnings[player_index] = settingsutil.get_runtime_setting(player_index, "turret-inspector-show-turret-warnings")
    end
    return SettingsWrapper.show_turret_warnings[player_index]
end

function SettingsWrapper.resetShowTurretWarnings()
    SettingsWrapper.show_turret_warnings = {}
end

function SettingsWrapper.readLowAmmo(player_index)
    if not SettingsWrapper.low_ammo[player_index] then
        SettingsWrapper.low_ammo[player_index] = settingsutil.get_runtime_setting(player_index, "turret-inspector-low-ammo")
    end
    return SettingsWrapper.low_ammo[player_index]
end

function SettingsWrapper.resetLowAmmo()
    SettingsWrapper.low_ammo = {}
end

function SettingsWrapper.onModSettingsChanged(event, logger)
    SettingsWrapper.readSettings()

    if event.setting == "spice-rack-turret-inspector-debug-mode" then
        
        logger.set_mode(settingswrapper.debug_mode)
        logger.set_print_to_console(constants.PRINT_TO_CONSOLE)

        logger.manual("debug mode changed", true)

    elseif event.setting == "spice-rack-turret-inspector-show-turret-warnings" then
        SettingsWrapper.resetShowTurretWarnings()

    elseif event.setting == "spice-rack-turret-inspector-low-ammo" then
        SettingsWrapper.resetLowAmmo()
    end
end

return SettingsWrapper