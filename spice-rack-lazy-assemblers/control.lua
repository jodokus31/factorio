local settingsutil = require('__spice-rack-core__/util/settingsutil')

script.on_event(defines.events.on_player_created, function(event)
    local player = game.players[event.player_index]
    if not player.character == nil then
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
        if get_runtime_setting("runtime-lazy-bastard-marathon") then
            player.insert { name = "electronic-circuit", count = 10}
            player.insert { name = "iron-gear-wheel", count = 40}
            player.insert { name = "pipe", count = 10}
        end
    end
end