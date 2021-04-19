local constants = require('script/constants')

local UpdateContainers = {}

UpdateContainers.logger = nil
UpdateContainers.settingswrapper = nil

UpdateContainers.containers = nil
UpdateContainers.itemvalues = nil
UpdateContainers.statistics = nil
UpdateContainers.slotgui = nil

function UpdateContainers.updateContainers()

    local update_slot = global.SpiceRack_UpdateSlot
    global.SpiceRack_UpdateSlot = (update_slot + 1) % UpdateContainers.settingswrapper.slot_count
    
    if UpdateContainers.settingswrapper.debug_mode >= 3 then
        UpdateContainers.slotgui.updateSlotGui(game.connected_players, update_slot)
    end

    if update_slot == 0 then
        UpdateContainers.statistics.copyStatistics()
    end

    local current_slot_containers = UpdateContainers.containers.getContainersToUpdate(update_slot)
    
    for _, container in pairs(current_slot_containers) do
        if container and container.entity then
            if container.entity.valid then
                local inventory = container.entity.get_inventory(defines.inventory.chest)
                local items = inventory.get_contents()
                for itemname, count in pairs(items) do
                    
                    if count >= constants.START_COUNT then
                        
                        local current_itemvalues = UpdateContainers.itemvalues.lookupItemValues(itemname)
                        if current_itemvalues.percent > 0 then
                            -- using a log curve from like 27% for 1 stack - 100% for 48 stacks
                            local fill_factor = math.log(1.3 + (math.min(count / current_itemvalues.stack_size, 48) / 32)) / math.log(1.3 + 1.5)
                            -- for statistics
                            local linear_fill_factor = (math.min(count / current_itemvalues.stack_size, 48) / 32) / 1.5

                            -- recalculate the given decay percent per hour to match the timespan defined by slots and interval
                            -- also consider the fill_factor
                            local per_hour_exponent = (UpdateContainers.settingswrapper.slot_count * UpdateContainers.settingswrapper.interval) / (60 * 60 * 60) 
                        
                            local decay_factor = (1 - (current_itemvalues.percent/100 * fill_factor)) ^ per_hour_exponent
                            -- for statistics
                            local max_decay_factor = (1 - (current_itemvalues.percent/100)) ^ per_hour_exponent

                            -- fractions of items cannot be removed, so we sum fractions per item until its bigger than 1
                            local old_fraction = current_itemvalues.fraction

                            local new_count = (count * decay_factor) - old_fraction
                            local new_count_ceiling = math.ceil(new_count);
                            local new_fraction = new_count_ceiling - new_count
                            
                            current_itemvalues.fraction = new_fraction

                            local int_diff = count - new_count_ceiling
                            if int_diff > 0 then
                                if UpdateContainers.settingswrapper.do_destroy_items then
                                    inventory.remove({ name = itemname, count = int_diff })
                                end

                                if UpdateContainers.settingswrapper.emit_pollution_amount >= 0.01 then
                                    if container.entity.surface and container.entity.position then
                                        container.entity.surface.pollute(container.entity.position, UpdateContainers.settingswrapper.emit_pollution_amount*int_diff)
                                    else
                                        UpdateContainers.logger.error("entity surface and position are not set")
                                    end
                                end
                            end
                            
                            UpdateContainers.logger.debug(string.format("slot: %03d %04d %04d %.4f %.4f %.4f, remove: %d %s (decay_percent: %.2f%%, fill_factor: %.2f%% real: %.4f%% every %.2f sec. from container %d", 
                                update_slot, 
                                count, new_count_ceiling, new_count, old_fraction, new_fraction,
                                int_diff, itemname, current_itemvalues.percent, fill_factor*100, (1-decay_factor)*100, per_hour_exponent*60*60, container.entity.unit_number))

                            UpdateContainers.statistics.updateStatistics(itemname, new_count_ceiling, new_fraction, int_diff, max_decay_factor, per_hour_exponent, linear_fill_factor)
                        end
                    end
                end
            else
                UpdateContainers.logger.warn("entity is not valid")
            end
        end
    end
end

return UpdateContainers