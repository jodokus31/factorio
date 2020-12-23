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
        if game.difficulty_settings.recipe_difficulty == 1 then
            if game.difficulty_settings.technology_price_multiplier == 4 then
                if settingsutil.get_startup_setting("lazy-bastard-marathon") then
                    player.insert { name = "copper-cable", count = 48}
                    player.insert { name = "iron-gear-wheel", count = 14}
                    -- player.insert { name = "iron-plate", count = 207}
                    -- player.insert { name = "copper-plate", count = 47}
                end
            end
        end
    end
end
