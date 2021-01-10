local constants = require('script/constants')
local settingsutil = require('__spice-rack-core__/util/settingsutil')

local SettingsWrapper = {}

SettingsWrapper.debug_mode = 0
SettingsWrapper.do_destroy_items = true
SettingsWrapper.emit_pollution_amount = 0
SettingsWrapper.slot_count = 0
SettingsWrapper.interval = 0

SettingsWrapper.logger = nil

function SettingsWrapper.readSettings(include_startup_settings)
    SettingsWrapper.debug_mode = settingsutil.get_global_setting("decaying-goods-debug-mode")
    
    if include_startup_settings then
        SettingsWrapper.do_destroy_items = settingsutil.get_startup_setting("decaying-goods-do-destroy-items")
        SettingsWrapper.emit_pollution_amount = settingsutil.get_startup_setting("decaying-goods-emit-pollution-amount")
        SettingsWrapper.slot_count = settingsutil.get_startup_setting("decaying-goods-slot-count")
        SettingsWrapper.interval = settingsutil.get_startup_setting("decaying-goods-interval")
    end
end

function SettingsWrapper.getItemPercent(itemname)
    return settingsutil.get_startup_setting("decaying-goods-decay-"..itemname)
end

return SettingsWrapper