local tableutil = require('__spice-rack-core__/util/tableutil')
local constants = require('script/constants')

local Containers = {}

Containers.logger = nil
Containers.settingswrapper = nil

function Containers.addContainer(entity)
    global.SpiceRack_Containers[entity.unit_number] = 
    { 
        entity = entity
    }
    tableutil.add(global.SpiceRack_SlotToUnitNumbers[global.SpiceRack_AddSlot], entity.unit_number)
    
    Containers.logger.info("add container " .. entity.unit_number .. " in slot " .. global.SpiceRack_AddSlot)

    global.SpiceRack_AddSlot = (global.SpiceRack_AddSlot + constants.SLOT_STEP) % Containers.settingswrapper.slot_count
end

function Containers.removeContainer(entity)
    table.remove(global.SpiceRack_Containers, entity.unit_number)

    local found_slot = nil
    local found_index = nil
    for slot, unit_numbers in pairs(global.SpiceRack_SlotToUnitNumbers) do
        found_index = tableutil.find(unit_numbers, function(u) return u == entity.unit_number end)
        if found_index then
            found_slot = slot
            break;
        end
    end

    if found_slot and found_index then
        table.remove(global.SpiceRack_SlotToUnitNumbers[found_slot], found_index)
        Containers.logger.info("remove container " .. entity.unit_number .. " in slot " .. found_slot)
    else
        Containers.logger.warn("remove container not found " .. entity.unit_number)
    end
end


function Containers.rebuildContainers()
    global.SpiceRack_Containers = {}
        
    global.SpiceRack_SlotToUnitNumbers = {}
    for i = 0, Containers.settingswrapper.slot_count - 1, 1 do
        global.SpiceRack_SlotToUnitNumbers[i] = {}
    end
    
    global.SpiceRack_AddSlot = 0

    for _, surface in pairs(game.surfaces) do
        local containers = surface.find_entities_filtered { type = {"container", "logistic-container"}}
        if containers then
            for _, container in pairs(containers) do
                Containers.addContainer(container)
            end
        end
    end
end

function Containers.logActiveContainers(logFunc)
    local count_sum = 0
    logFunc("active containers:")
    for slot = 0, Containers.settingswrapper.slot_count - 1, 1 do
        local unit_numbers = global.SpiceRack_SlotToUnitNumbers[slot]
        local parts = ""
        local count = 0
        for _, unit_number in pairs(unit_numbers) do
            count = count + 1
            parts = parts .. unit_number .." "
        end
        logFunc("slot: "..slot ..", count " .. count .. ", unit_numbers: " .. parts)
        count_sum = count_sum + count
    end
    logFunc("overall count: " .. count_sum)
end

function Containers.getContainersToUpdate(slot)
    local list = {}
    
    local unit_numbers_to_update = global.SpiceRack_SlotToUnitNumbers[slot]
    for _, unit_number in pairs(unit_numbers_to_update) do 
        local container = global.SpiceRack_Containers[unit_number]
        table.insert(list, container)
    end
    return list
end

function Containers.handleAddContainer(args)
    local entity = args.created_entity or args.entity
    if entity and entity.valid then
        Containers.addContainer(entity)
    end
end

function Containers.handleRemoveContainer(args)
    local entity = args.entity
    --Containers.logger.info("handleRemoveContainer :" .. tostring(entity.valid))
    if entity and entity.valid then
        Containers.removeContainer(entity)
    end
end

function Containers.handleRemoveSurface(args)
    local surface = game.surfaces[args.surface_index]
    if surface then
        local entities = surface.find_entities_filtered { type = {"logistic-container", "container"}}
        if entities then
            for _, entity in pairs(entities) do
                Containers.removeContainer(entity)
            end
        end
    end
end

function Containers.registerEvents()
    local container_filter = { { filter = "type", type = "container"}, { mode = "or", filter = "type", type = "logistic-container"} }

    script.on_event( defines.events.on_built_entity, Containers.handleAddContainer, container_filter)
    script.on_event( defines.events.on_robot_built_entity, Containers.handleAddContainer, container_filter)
    script.on_event( defines.events.script_raised_built, Containers.handleAddContainer, container_filter)
    script.on_event( defines.events.script_raised_revive, Containers.handleAddContainer, container_filter)
    
    script.on_event( defines.events.on_pre_player_mined_item, Containers.handleRemoveContainer, container_filter)
    --script.on_event( defines.events.on_robot_pre_mined, Containers.handleRemoveContainer, container_filter)
    script.on_event( defines.events.on_robot_mined_entity, Containers.handleRemoveContainer, container_filter)
    script.on_event( defines.events.on_entity_died, Containers.handleRemoveContainer, container_filter)
    script.on_event( defines.events.script_raised_destroy, Containers.handleRemoveContainer, container_filter)
    
    script.on_event(
        { 
            defines.events.on_pre_surface_deleted, 
            defines.events.on_pre_surface_cleared 
        },
        Containers.handleRemoveSurface)
end

return Containers