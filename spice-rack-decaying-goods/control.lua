
local tableutil = require('__spice-rack-core__/util/tableutil')
local logger = require('__spice-rack-core__/util/logger')

local constants = require('script/constants')
local settingswrapper = require('script/settingswrapper')

local containers = require('script/containers')
local itemvalues = require('script/itemvalues')

local updateContainers = require('script/updatecontainers')

local statistics = require('script/statistics')
local slotgui = require('script/slotgui')

local item_decay_defaults = require('item_decay_defaults')

local function attachUpdateContainers()
    updateContainers.containers = containers
    updateContainers.itemvalues = itemvalues
    updateContainers.statistics = statistics
    updateContainers.slotgui = slotgui

    script.on_nth_tick(settingswrapper.interval, updateContainers.updateContainers)
end

local function setupSettingsAndLogger()
    settingswrapper.readSettings(true)
    logger.set_mode(settingswrapper.debug_mode)
    logger.set_print_to_console(constants.PRINT_TO_CONSOLE)

    settingswrapper.logger = logger

    containers.settingswrapper = settingswrapper
    itemvalues.settingswrapper = settingswrapper
    updateContainers.settingswrapper = settingswrapper
    
    containers.logger = logger
    itemvalues.logger = logger
    updateContainers.logger = logger

    statistics.logger = logger
end

script.on_init(function()
    setupSettingsAndLogger()

    slotgui.resetSlotGui(game.connected_players)

    containers.rebuildContainers()
    itemvalues.rebuildItemValues()

    global.SpiceRack_Decaying_Goods_UpdateSlot = 0

    statistics.resetStatistics()
    
    containers.registerEvents()
    attachUpdateContainers()
end)

script.on_configuration_changed(function()
    setupSettingsAndLogger()

    slotgui.resetSlotGui(game.connected_players)

    containers.rebuildContainers()
    itemvalues.rebuildItemValues()

    global.SpiceRack_Decaying_Goods_UpdateSlot = 0
    
    --Never reset statistics
    --statistics.resetStatistics()
    containers.registerEvents()
    attachUpdateContainers()
end)

script.on_load(function()
    setupSettingsAndLogger()

    containers.registerEvents()
    attachUpdateContainers()
end)


script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
    settingswrapper.readSettings()

    if event.setting == "spice-rack-decaying-goods-debug-mode" then
        
        logger.set_mode(settingswrapper.debug_mode)
        logger.set_print_to_console(constants.PRINT_TO_CONSOLE)

        slotgui.resetSlotGui(game.connected_players)

        logger.manual("debug mode changed", true)
    end
end)


commands.add_command("spice_rack_item_statistics", "displays a statistics about items and how much already decayed", function()
    local nextUpdateInSec = (settingswrapper.slot_count - global.SpiceRack_Decaying_Goods_UpdateSlot) * settingswrapper.interval / 60
    statistics.logStatistics(nextUpdateInSec)
end)

commands.add_command("spice_rack_active_containers", "displays all containers (chests)", function()
    containers.logActiveContainers(function (text) logger.manual(text, true) end)
end)

commands.add_command("spice_rack_rebuild_containers", "rebuild the containers structure, if necessary", function()
    containers.rebuildContainers()
end)

