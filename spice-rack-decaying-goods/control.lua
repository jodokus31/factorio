
local tableutil = require('__spice-rack-core__/util/tableutil')
local logger = require('__spice-rack-core__/util/logger')

local constants = require('script/constants')
local settingswrapper = require('script/settingswrapper')

local containers = require('script/containers')
local itemvalues = require('script/itemvalues')

local statistics = require('script/statistics')
local slotgui = require('script/slotgui')

local item_decay_defaults = require('item_decay_defaults')

local function updateContainers()
    local update_slot = global.SpiceRack_UpdateSlot
    global.SpiceRack_UpdateSlot = (update_slot + 1) % settingswrapper.slot_count
    
    if settingswrapper.debug_mode >= 3 then
        slotgui.updateSlotGui(game.connected_players, update_slot)
    end

    if update_slot == 0 then
        statistics.copyStatistics()
    end

    for _, container in pairs(containers.getContainersToUpdate(update_slot)) do
        if container and container.entity then
            if container.entity.valid then
                local inventory = container.entity.get_inventory(defines.inventory.chest)
                local items = inventory.get_contents()
                for itemname, count in pairs(items) do
                    
                    if count >= constants.START_COUNT then
                        
                        local item_values = itemvalues.lookupItemValues(itemname)
                        if item_values.percent > 0 then
                            -- using a log curve from like 27% for 1 stack - 100% for 48 stacks
                            local fill_factor = math.log(1.3 + (math.min(count / item_values.stack_size, 48) / 32)) / math.log(1.3 + 1.5)
                            -- for statistics
                            local linear_fill_factor = (math.min(count / item_values.stack_size, 48) / 32) / 1.5

                            -- recalculate the given decay percent per hour to match the timespan defined by slots and interval
                            -- also consider the fill_factor
                            local per_hour_exponent = (settingswrapper.slot_count * settingswrapper.interval) / (60 * 60 * 60) 
                        
                            local decay_factor = (1 - (item_values.percent/100 * fill_factor)) ^ per_hour_exponent
                            -- for statistics
                            local max_decay_factor = (1 - (item_values.percent/100)) ^ per_hour_exponent

                            -- fractions of items cannot be removed, so we sum fractions per item until its bigger than 1
                            local old_fraction = item_values.fraction

                            local new_count = (count * decay_factor) - old_fraction
                            local new_count_ceiling = math.ceil(new_count);
                            local new_fraction = new_count_ceiling - new_count
                            
                            item_values.fraction = new_fraction

                            local int_diff = count - new_count_ceiling
                            if int_diff > 0 then
                                if settingswrapper.do_destroy_items then
                                    inventory.remove({ name = itemname, count = int_diff })
                                end

                                if settingswrapper.emit_pollution_amount >= 0.01 then
                                    if container.entity.surface and container.entity.position then
                                        container.entity.surface.pollute(container.entity.position, settingswrapper.emit_pollution_amount*int_diff)
                                    else
                                        logger.error("entity surface and position are not set")
                                    end
                                end
                            end
                            
                            logger.debug(string.format("slot: %03d %04d %04d %.4f %.4f %.4f, remove: %d %s (decay_percent: %.2f%%, fill_factor: %.2f%% real: %.4f%% every %.2f sec. from container %d", 
                                update_slot, 
                                count, new_count_ceiling, new_count, old_fraction, new_fraction,
                                int_diff, itemname, item_values.percent, fill_factor*100, (1-decay_factor)*100, per_hour_exponent*60*60, container.entity.unit_number))

                            statistics.updateStatistics(itemname, new_count_ceiling, new_fraction, int_diff, max_decay_factor, per_hour_exponent, linear_fill_factor)
                        end
                    end
                end
            else
                logger.warning("entity is not valid")
            end
        end
    end
end

local function attachUpdateContainers()
    script.on_nth_tick(settingswrapper.interval, updateContainers)
end

local function reinitializeLogger()
    logger.set_mode(settingswrapper.debug_mode)
    logger.set_print_to_console(constants.PRINT_TO_CONSOLE)
end

local function assignSettingsAndLogger()
    containers.settingswrapper = settingswrapper
    itemvalues.settingswrapper = settingswrapper
    
    containers.logger = logger
    itemvalues.logger = logger

    statistics.logger = logger
    settingswrapper.logger = logger
end

script.on_load(function()
    settingswrapper.readSettings(true)
    reinitializeLogger()
    assignSettingsAndLogger()

    containers.registerEvents()
    attachUpdateContainers()
end)

script.on_init(function()
    settingswrapper.readSettings(true)
    reinitializeLogger()
    assignSettingsAndLogger()

    slotgui.resetSlotGui(game.connected_players)

    containers.rebuildContainers()
    itemvalues.rebuildItemValues()
    global.SpiceRack_UpdateSlot = 0
    statistics.resetStatistics()
    
    containers.registerEvents()
    attachUpdateContainers()
end)

script.on_configuration_changed(function()
    settingswrapper.readSettings(true)
    reinitializeLogger()
    assignSettingsAndLogger()

    slotgui.resetSlotGui(game.connected_players)

    containers.rebuildContainers()
    itemvalues.rebuildItemValues()
    global.SpiceRack_UpdateSlot = 0
    
    containers.registerEvents()
    attachUpdateContainers()
end)


script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
    settingswrapper.readSettings()

    if event.setting == "spice-rack-decaying-goods-debug-mode" then
        
        logger.manual("debug mode changed", true)
        reinitializeLogger()

        slotgui.resetSlotGui(game.connected_players)
    end
end)


commands.add_command("spice_rack_item_statistics", "display all considered items", function()
    local nextUpdateInSec = (settingswrapper.slot_count - global.SpiceRack_UpdateSlot) * settingswrapper.interval / 60
    statistics.logStatistics(nextUpdateInSec)
end)

commands.add_command("spice_rack_active_containers", "display all containers", function()
    containers.logActiveContainers(function (text) logger.manual(text, true) end)
end)

commands.add_command("spice_rack_rebuild_containers", "rebuild containers", function()
    containers.rebuildContainers()
end)

