local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Lazy Assemblers
if settingsutil.get_startup_setting("crafting-limitation-mode") ~= "disabled" then

    local recipe_categories = {
        ["assembler2"] =
            {
                "assembling-machine-2",
                "assembling-machine-3",
                "electric-furnace",

                "oil-refinery",
                "pumpjack", 
                "chemical-plant",
                
                "centrifuge",
                "nuclear-reactor",
                "steam-turbine",
                "heat-exchanger",
                
                "chemical-science-pack",
                "production-science-pack",
                "utility-science-pack",

                "beacon",
                "productivity-module",
                "speed-module",
                "effectivity-module",
            },
            
        ["nohandcraft_assembler2"] =
            {
                "low-density-structure",
                "flying-robot-frame",
                "advanced-circuit",

                "productivity-module-2",
                "speed-module-2",
                "effectivity-module-2",
            
                "uranium-fuel-cell",
                "uranium-rounds-magazine",
                "uranium-cannon-shell",
                
                "car",
                "tank",
                "locomotive",
                "cargo-wagon",
                "fluid-wagon",

                "artillery-turret",
                "artillery-wagon",
                "artillery-shell",
            },

        ["nohandcraft_assembler3"] =
            {
                "productivity-module-3",
                "speed-module-3",
                "effectivity-module-3",

                "rocket-control-unit",

                "rocket-silo",
                "satellite",

                "spidertron",
                "spidertron-remote",
                "atomic-bomb",
            },
        }

    for _, recipe in pairs(data.raw.recipe) do
        -- only overwrite nil or category "crafting"
        if recipe and (recipe.category == nil or recipe.category == "crafting") then

            for category, recipe_names in pairs(recipe_categories) do
                
                local _, recipename = tableutil.find(
                    recipe_names,
                    function(n) return n == recipe.name end)
                
                if recipename then
                    recipe.category = category
                    break;
                end
            end
        end
    end
end
------ << Lazy Assemblers
