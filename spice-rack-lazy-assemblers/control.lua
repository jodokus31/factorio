local settingsutil = require('__spice-rack-core__/util/settingsutil')

script.on_init(function()
    if game.difficulty_settings.recipe_difficulty ~= 1 then return end
    if game.difficulty_settings.technology_price_multiplier ~= 4 then return end

    if settingsutil.get_startup_setting("lazy-bastard-marathon") then
        if remote.interfaces["freeplay"] ~= nil then
            debris_items = remote.call("freeplay", "get_debris_items")
            debris_items["copper-cable"] = (debris_items["copper-cable"] or 0) + 48
            debris_items["iron-gear-wheel"] = (debris_items["iron-gear-wheel"] or 0) + 14
            remote.call("freeplay", "set_debris_items", debris_items)
        end
    end
end)
