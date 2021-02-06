local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Landmine

if settingsutil.get_startup_setting("landmine-change") then
    -- {
    --     type = "recipe",
    --     name = "land-mine",
    --     ingredients =
    --     {
    --       {"steel-plate", 1},
    --       {"explosives", 2}
    --     },
    -- },

    data.raw.recipe['land-mine'].ingredients = { {"steel-plate", 2}, {"explosives", 4} }
end

if settingsutil.get_startup_setting("flamethrower-change") then
    -- type = "recipe",
    -- name = "flamethrower-ammo",
    -- category = "chemistry",
    -- enabled = false,
    -- energy_required = 6,
    -- ingredients =
    -- {
    --   {type="item", name="steel-plate", amount=5},
    --   {type="fluid", name="crude-oil", amount=100}
    -- },
    -- result = "flamethrower-ammo",

    data.raw.recipe['flamethrower-ammo'].ingredients = { 
        { type="item", name="steel-plate", amount=5 },
        { type="fluid", name="light-oil", amount=100 } 
    }
end

------ << Landmine

------ >> Tank
if settingsutil.get_startup_setting("tank-change") then
    -- type = "recipe",
    -- name = "tank",
    -- ingredients =
    -- {
    --     {"engine-unit", 32},
    --     {"steel-plate", 50},
    --     {"iron-gear-wheel", 15},
    --     {"advanced-circuit", 10}
    -- },

    data.raw.recipe['tank'].ingredients = {
        {"engine-unit", 96},
        {"steel-plate", 100},
        {"iron-gear-wheel", 100},
        {"advanced-circuit", 50}
    }

end
------ << Tank

------ >> Repair pack
if settingsutil.get_startup_setting("repair-pack-change") then
    -- type = "recipe",
    -- name = "repair-pack",
    -- ingredients =
    -- {
    --   {"electronic-circuit", 2},
    --   {"iron-gear-wheel", 2}
    -- },

    data.raw.recipe['repair-pack'].ingredients = {
        {"electronic-circuit", 3},
        {"iron-gear-wheel", 3}
    }
end
------ << Repair pack