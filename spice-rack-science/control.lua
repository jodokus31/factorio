local settingsutil = require('__spice-rack-core__/util/settingsutil')

script.on_event(defines.events.on_player_created, function(event)
    local player = game.players[event.player_index]
    if not player.character == nil then
        on_player_creation(player)
    end
end)

script.on_event(defines.events.on_cutscene_cancelled, function(event)
    local player = game.players[event.player_index]
    on_player_creation(player)
end)

function on_player_creation(player)
    if settingsutil.get_runtime_setting("runtime-add-lamps") then
        player.insert { name = "small-lamp", count = 10}
    end
end
