local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Lazy Assemblers
if settingsutil.get_startup_setting("crafting-limitation-mode") ~= "disabled" then
    tableutil.add(data.raw['character']['character'].crafting_categories, "assembler2")

    if settingsutil.get_startup_setting("crafting-limitation-mode") == "assemblers only" then
        tableutil.add(data.raw['character']['character'].crafting_categories, "nohandcraft_assembler2")
        tableutil.add(data.raw['character']['character'].crafting_categories, "nohandcraft_assembler3")
    end

    tableutil.add(data.raw['assembling-machine']['assembling-machine-2'].crafting_categories, "assembler2")
    tableutil.add(data.raw['assembling-machine']['assembling-machine-2'].crafting_categories, "nohandcraft_assembler2")

    tableutil.add(data.raw['assembling-machine']['assembling-machine-3'].crafting_categories, "assembler2")
    tableutil.add(data.raw['assembling-machine']['assembling-machine-3'].crafting_categories, "nohandcraft_assembler2")
    tableutil.add(data.raw['assembling-machine']['assembling-machine-3'].crafting_categories, "nohandcraft_assembler3")
end
------ << Lazy Assemblers
