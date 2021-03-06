local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Lazy Assemblers
if settingsutil.get_startup_setting("crafting-limitation-mode") ~= "disabled" then

    local recipe_categories = {
        ["assembler2"] = {},
        ["assembler2_nohandcraft"] = {},
        ["assembler3"] = {},
        ["assembler3_nohandcraft"] = {},
    }
    
    recipe_categories["assembler2"] =
        {
            "assembling-machine-3",
            "electric-furnace",
            
            "pumpjack", 
            "chemical-plant",
            
            "steam-turbine",
            "heat-exchanger",
            
            "chemical-science-pack",
            "production-science-pack",
            "utility-science-pack",

            "beacon",
            
            "productivity-module",
            "speed-module",
            "effectivity-module",
        }

    recipe_categories["assembler2_nohandcraft"] =
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
        }

    recipe_categories["assembler3"] =
        {
            "centrifuge",
            "nuclear-reactor",

            "satellite",
            
            "spidertron-remote",
        }

    recipe_categories["assembler3_nohandcraft"] =
        {
            "productivity-module-3",
            "speed-module-3",
            "effectivity-module-3",
            
            "rocket-control-unit",
            "rocket-silo",
            
            "spidertron",
            
            "atomic-bomb",
        }

    if settingsutil.get_startup_setting("classic-lazy-bastard") then
        table.insert(recipe_categories["assembler2"], "assembling-machine-2")
        table.insert(recipe_categories["assembler3"], "oil-refinery")
    else
        table.insert(recipe_categories["assembler2"], "oil-refinery")
    end


    for _, recipe in pairs(data.raw.recipe) do
        -- only overwrite category empty or "crafting"
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
