local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Lazy Assemblers
if settingsutil.get_startup_setting("crafting-limitation-mode") ~= "disabled" then

    tableutil.add(data.raw['character']['character'].crafting_categories, "assembler2", true)
    tableutil.add(data.raw['character']['character'].crafting_categories, "assembler3", true)

    if settingsutil.get_startup_setting("crafting-limitation-mode") == "assembler only" then
        
        -- character should be able to handcraft in this mode
        tableutil.add(data.raw['character']['character'].crafting_categories, "assembler2_nohandcraft", true)
        tableutil.add(data.raw['character']['character'].crafting_categories, "assembler3_nohandcraft", true)
    end

    tableutil.add(data.raw['assembling-machine']['assembling-machine-2'].crafting_categories, "assembler2", true)
    tableutil.add(data.raw['assembling-machine']['assembling-machine-2'].crafting_categories, "assembler2_nohandcraft", true)


    local highest_tiers = {"assembling-machine-3", "assembling-machine-4", "assembling-machine-5", "assembling-machine-6"}

    for _, highest_tier in pairs(highest_tiers) do
    
        if data.raw['assembling-machine'][highest_tier] then

            tableutil.add(data.raw['assembling-machine'][highest_tier].crafting_categories, "assembler2", true)
            tableutil.add(data.raw['assembling-machine'][highest_tier].crafting_categories, "assembler2_nohandcraft", true)

            tableutil.add(data.raw['assembling-machine'][highest_tier].crafting_categories, "assembler3", true)
            tableutil.add(data.raw['assembling-machine'][highest_tier].crafting_categories, "assembler3_nohandcraft", true)
        end
    end
    
end

------ << Lazy Assemblers
