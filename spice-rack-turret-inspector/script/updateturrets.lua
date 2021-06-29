local constants = require('script/constants')

local UpdateTurrets = {}


UpdateTurrets.logger = nil
UpdateTurrets.settingswrapper = nil

UpdateTurrets.turrets = nil

UpdateTurrets.current_players = nil

function UpdateTurrets.updateTurrets()

    local update_slot = global.SpiceRack_TurretInspector_UpdateSlot
    global.SpiceRack_TurretInspector_UpdateSlot = (update_slot + 1) % UpdateTurrets.settingswrapper.slot_count
    
    local turrets_per_force = UpdateTurrets.turrets.getTurretsToUpdatePerForce(update_slot, game.tick)
    
    -- update current_players once every ~10 sec.
    if (update_slot == 0) or (UpdateTurrets.current_players == nil) then
        
        UpdateTurrets.current_players = {}

        for _, player in pairs(game.connected_players) do
            if player.valid and UpdateTurrets.settingswrapper.readShowTurretWarnings(player.index) then

                local force_name = player.force.name
                UpdateTurrets.current_players[force_name] = UpdateTurrets.current_players[force_name] or {}
                table.insert(UpdateTurrets.current_players[force_name], player)

            end
        end
    end

    for force_name, players in pairs(UpdateTurrets.current_players) do
        
        local force_turrets = turrets_per_force[force_name]
        if force_turrets then
            
            for _, turret in pairs(force_turrets) do

                if turret and turret.entity and turret.entity.valid then
                    local entity = turret.entity
                    local automated_ammo_count = turret.automated_ammo_count

                    local turret_ammo_count = 999999
                    
                    if entity.type == "ammo-turret" then
                        inventory = entity.get_inventory(defines.inventory.turret_ammo)
                        if inventory and inventory.valid then 
                            if inventory.is_empty() then
                                turret_ammo_count = 0
                            else
                                turret_ammo_count = inventory.get_item_count()
                            end
                        end
                    end
                    
                    -- skip, if ammo equals automatically filled ammo amount
                    -- f.e. if auto amount is 10 and low ammo threshold 15:
                    -- -> no warning if exactly 10
                    -- -> warning if 9 or 11
                    if automated_ammo_count ~= turret_ammo_count then

                        for _, player in pairs(players) do
                            
                            if player.valid then

                                local status = constants.OK

                                if turret_ammo_count <= 0 then
                                    status = constants.EMPTY

                                elseif turret_ammo_count < UpdateTurrets.settingswrapper.readAmmoAlmostEmpty(player.index) then
                                    status = constants.ALMOST_EMPTY

                                elseif turret_ammo_count < UpdateTurrets.settingswrapper.readAmmoLow(player.index) then
                                    status = constants.LOW
                                end

                                if status == constants.EMPTY then
                                    player.add_custom_alert(entity, 
                                        {type = "virtual", name = "ammo-empty"}, 
                                        {"spice-rack-turret-inspector.message-ammo-empty", entity.localised_name}, 
                                        true)

                                elseif status == constants.ALMOST_EMPTY then
                                    player.add_custom_alert(entity, 
                                        {type = "virtual", name = "ammo-almost-empty"}, 
                                        {"spice-rack-turret-inspector.message-ammo-almost-empty", entity.localised_name}, 
                                        true)

                                elseif status == constants.LOW then
                                    player.add_custom_alert(entity, 
                                        {type = "virtual", name = "ammo-low"}, 
                                        {"spice-rack-turret-inspector.message-ammo-low", entity.localised_name}, 
                                        true)

                                
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

return UpdateTurrets