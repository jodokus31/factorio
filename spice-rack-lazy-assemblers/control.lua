local settingsutil = require('__spice-rack-core__/util/settingsutil')

script.on_event(defines.events.on_player_created, function(event)
    local player = game.players[event.player_index]
    if player.character then
        on_player_creation(player, event.player_index)
    end
end)

script.on_event(defines.events.on_cutscene_cancelled, function(event)
    local player = game.players[event.player_index]
    on_player_creation(player, event.player_index)
end)

function on_player_creation(player, player_index)
    -- only first player gets it 
    if player_index == 1 then
        if settingsutil.get_startup_setting("lazy-bastard-marathon") then
            player.insert { name = "copper-cable", count = 96}
            player.insert { name = "iron-gear-wheel", count = 48}
        end
    end
end
