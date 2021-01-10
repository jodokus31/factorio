local SlotGui = {}

function SlotGui.updateSlotGui(players, slot)
    for _, player in pairs(players) do    
        
        local player_gui = player.gui.top
            
        if player_gui.sr_slot == nil then 
            player_gui.add { 
                type="label", 
                name="sr_slot"
            }
        end

        player_gui.sr_slot.caption = string.format("%d", slot)
    end
end

function SlotGui.resetSlotGui(players)
    for _, player in pairs(players) do
    
        local player_gui = player.gui.top

        if player_gui.sr_slot ~= nil then 
            player_gui.sr_slot.destroy()
        end
    end
end

return SlotGui