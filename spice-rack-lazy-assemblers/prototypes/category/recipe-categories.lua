local settingsutil = require('__spice-rack-core__/util/settingsutil')

------ >> Lazy Assemblers
if settingsutil.get_startup_setting("crafting-limitation-mode") ~= "disabled" then
    data:extend(
    {
        {
            type = "recipe-category",
            name = "assembler2"
        },
        {
            type = "recipe-category",
            name = "assembler2_nohandcraft"
        },
        {
            type = "recipe-category",
            name = "assembler3"
        },
        {
            type = "recipe-category",
            name = "assembler3_nohandcraft"
        },
    })
end
------ << Lazy Assemblers
