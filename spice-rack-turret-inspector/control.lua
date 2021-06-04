local tableutil = require('__spice-rack-core__/util/tableutil')
local logger = require('__spice-rack-core__/util/logger')

local constants = require('script/constants')
local settingswrapper = require('script/settingswrapper')

local turrets = require('script/turrets')
local updateTurrets = require('script/updateturrets')

local function attachUpdateTurrets()
    updateTurrets.turrets = turrets

    script.on_nth_tick(settingswrapper.interval, updateTurrets.updateTurrets)
end

local function setupSettingsAndLogger()
    settingswrapper.readSettings(true)
    logger.set_mode(settingswrapper.debug_mode)
    logger.set_print_to_console(constants.PRINT_TO_CONSOLE)

    settingswrapper.logger = logger

    turrets.settingswrapper = settingswrapper
    updateTurrets.settingswrapper = settingswrapper
    
    turrets.logger = logger
    updateTurrets.logger = logger
end

script.on_init(function()
    --logger.manual("on_init")
    setupSettingsAndLogger()

    turrets.rebuildTurrets()

    global.SpiceRack_TurretInspector_UpdateSlot = 0

    turrets.registerEvents()
    attachUpdateTurrets()
end)

script.on_configuration_changed(function()
    --logger.manual("on_configuration_changed")
    setupSettingsAndLogger()

    turrets.rebuildTurrets()

    global.SpiceRack_TurretInspector_UpdateSlot = 0
    
    turrets.registerEvents()
    attachUpdateTurrets()
end)

script.on_load(function()
    --logger.manual("on_load")
    setupSettingsAndLogger()

    turrets.registerEvents()
    attachUpdateTurrets()
end)


script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
    settingswrapper.onModSettingsChanged(event, logger)
end)

commands.add_command("spice_rack_active_turrets", "displays all turrets", function()
    turrets.logActiveTurrets(function (text) logger.manual(text, true) end)
end)