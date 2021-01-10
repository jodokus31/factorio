
local function displayTime(nthTickEventArgs)
    if not nthTickEventArgs then
        return
    end

    local total_seconds = math.floor(nthTickEventArgs.tick/60)

    local display_seconds = math.floor(total_seconds) % 60
    local display_minutes = math.floor(total_seconds/60) % 60
    local display_hours = math.floor(total_seconds/3600)

    for _, player in pairs(game.connected_players) do
        
        local player_gui = player.gui.top
            
        if player_gui.sr_clock == nil then 
            player_gui.add { 
                type="label", 
                name="sr_clock",
                tooltip={"spice-rack-gui.time-display-tooltip"},
                style = "spice_rack_gui_time_display_label"
            }
        end

        player_gui.sr_clock.caption = 
            string.format("%02d:%02d:%02d", 
                display_hours, 
                display_minutes, 
                display_seconds)
        
    end
end

script.on_nth_tick(60, displayTime)

script.on_configuration_changed(function()
    for _, player in pairs(game.connected_players) do
        local player_gui = player.gui.top
        
        if player_gui.sr_clock ~= nil then 
            player_gui.sr_clock.destroy()
        end
    end
end)