local tableutil = require('__spice-rack-core__/util/tableutil')
local constants = require('script/constants')

local Turrets = {}

Turrets.logger = nil
Turrets.settingswrapper = nil

function Turrets.addTurret(entity)
    global.SpiceRack_TurretInspector_Turrets[entity.unit_number] = 
    { 
        entity = entity,
        force_name = entity.force.name,
        automated_ammo_count = entity.prototype.automated_ammo_count,
        created_tick = game.tick,
    }

    tableutil.add(global.SpiceRack_TurretInspector_SlotToUnitNumbers[global.SpiceRack_TurretInspector_AddSlot], entity.unit_number)
    
    Turrets.logger.info("add turret " .. entity.unit_number .. " in slot " .. global.SpiceRack_TurretInspector_AddSlot)
    if entity.force.name == nil then
        Turrets.logger.warn("turret has no force")
    end

    global.SpiceRack_TurretInspector_AddSlot = (global.SpiceRack_TurretInspector_AddSlot + constants.SLOT_STEP) % Turrets.settingswrapper.slot_count
end

function Turrets.removeTurret(entity)
    table.remove(global.SpiceRack_TurretInspector_Turrets, entity.unit_number)

    local found_slot = nil
    local found_index = nil
    for slot, unit_numbers in pairs(global.SpiceRack_TurretInspector_SlotToUnitNumbers) do
        found_index = tableutil.find(unit_numbers, function(u) return u == entity.unit_number end)
        if found_index then
            found_slot = slot
            break;
        end
    end

    if found_slot and found_index then
        table.remove(global.SpiceRack_TurretInspector_SlotToUnitNumbers[found_slot], found_index)
        Turrets.logger.info("remove turret " .. entity.unit_number .. " in slot " .. found_slot)
    else
        Turrets.logger.warn("remove turret not found " .. entity.unit_number)
    end
end


function Turrets.rebuildTurrets()
    global.SpiceRack_TurretInspector_Turrets = {}
        
    global.SpiceRack_TurretInspector_SlotToUnitNumbers = {}
    for i = 0, Turrets.settingswrapper.slot_count - 1, 1 do
        global.SpiceRack_TurretInspector_SlotToUnitNumbers[i] = {}
    end
    
    global.SpiceRack_TurretInspector_AddSlot = 0

    for _, surface in pairs(game.surfaces) do
        local turrets = surface.find_entities_filtered { type = {"ammo-turret"}}
        if turrets then
            for _, container in pairs(turrets) do
                Turrets.addTurret(container)
            end
        end
    end
end

function Turrets.logActiveTurrets(logFunc)
    local count_sum = 0
    logFunc("active Turrets:")
    for slot = 0, Turrets.settingswrapper.slot_count - 1, 1 do
        local unit_numbers = global.SpiceRack_TurretInspector_SlotToUnitNumbers[slot]
        local count = 0
        if next(unit_numbers) then
            local parts = ""
            for _, unit_number in pairs(unit_numbers) do
                count = count + 1
                parts = parts .. unit_number.. "("..global.SpiceRack_TurretInspector_Turrets[unit_number].force_name ..") "
            end
            logFunc("slot: "..slot ..", count " .. count .. ", unit_numbers: " .. parts)
        end
        count_sum = count_sum + count
    end
    logFunc("overall count: " .. count_sum)
end

function Turrets.getTurretsToUpdatePerForce(slot, tick)
    local turrets_per_force = {}
    
    local unit_numbers_to_update = global.SpiceRack_TurretInspector_SlotToUnitNumbers[slot]
    for _, unit_number in pairs(unit_numbers_to_update) do 
        
        local turret = global.SpiceRack_TurretInspector_Turrets[unit_number]

        if (tick - (turret.created_tick or 0) > constants.WAIT_TICKS_FOR_NEWLY_PLACED_TURRETS) then
            
            local force_name = turret.force_name
            turrets_per_force[force_name] = turrets_per_force[force_name] or {}
            table.insert(turrets_per_force[force_name], turret)
        end
    end
    return turrets_per_force
end

function Turrets.handleAdd(args)
    local entity = args.created_entity or args.entity
    if entity and entity.valid then
        Turrets.addTurret(entity)
    end
end

function Turrets.handleRemove(args)
    local entity = args.entity
    if entity and entity.valid then
        Turrets.removeTurret(entity)
    end
end

function Turrets.handleRemoveSurface(args)
    local surface = game.surfaces[args.surface_index]
    if surface then
        local unit_numbers_to_delete = {}
        for unit_number, entity in pairs(global.SpiceRack_TurretInspector_Turrets) do
            if entity and entity.surface == surface then
                table.insert(unit_numbers_to_delete, unit_number)
            end
        end

        for _, unit_number in pairs(unit_numbers_to_delete) do
            Turrets.removeTurret(global.SpiceRack_TurretInspector_Turrets[unit_number])
        end
    end
end

function Turrets.registerEvents()
    local turret_filter = { { filter = "type", type = "ammo-turret"} }

    script.on_event( defines.events.on_built_entity, Turrets.handleAdd, turret_filter)
    script.on_event( defines.events.on_robot_built_entity, Turrets.handleAdd, turret_filter)
    script.on_event( defines.events.script_raised_built, Turrets.handleAdd, turret_filter)
    script.on_event( defines.events.script_raised_revive, Turrets.handleAdd, turret_filter)
    
    script.on_event( defines.events.on_pre_player_mined_item, Turrets.handleRemove, turret_filter)
    --script.on_event( defines.events.on_robot_pre_mined, Turrets.handleRemove, turret_filter)
    script.on_event( defines.events.on_robot_mined_entity, Turrets.handleRemove, turret_filter)
    script.on_event( defines.events.on_entity_died, Turrets.handleRemove, turret_filter)
    script.on_event( defines.events.script_raised_destroy, Turrets.handleRemove, turret_filter)
    
    script.on_event(
        { 
            defines.events.on_pre_surface_deleted, 
            defines.events.on_pre_surface_cleared 
        },
        Turrets.handleRemoveSurface)
end

return Turrets