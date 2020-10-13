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


    tableutil.add(data.raw['assembling-machine']['assembling-machine-3'].crafting_categories, "assembler2", true)
    tableutil.add(data.raw['assembling-machine']['assembling-machine-3'].crafting_categories, "assembler2_nohandcraft", true)

    tableutil.add(data.raw['assembling-machine']['assembling-machine-3'].crafting_categories, "assembler3", true)
    tableutil.add(data.raw['assembling-machine']['assembling-machine-3'].crafting_categories, "assembler3_nohandcraft", true)
end

------ << Lazy Assemblers
