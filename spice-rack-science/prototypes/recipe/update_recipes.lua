local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Lab
if settingsutil.get_startup_setting("lab-change") then
    -- name = "lab",
    -- energy_required = 2,
    -- ingredients =
    -- {
    --   {"electronic-circuit", 10},
    --   {"iron-gear-wheel", 10},
    --   {"transport-belt", 4}
    -- },

    tableutil.add(data.raw.recipe['lab'].ingredients, {"small-lamp", 1} )
    
    data.raw.recipe['lab'].energy_required = 5
end
------ << Lab

------ >> Furnace & Drill Progression

if settingsutil.get_startup_setting("furnace-progression") then
    --     name = "stone-furnace",
    --     ingredients = {{"stone", 5}},

    data.raw.recipe['stone-furnace'].ingredients = { {"stone-brick", 5} }

    --     name = "steel-furnace",
    --     ingredients = {{"steel-plate", 6}, {"stone-brick", 10}},

    data.raw.recipe['steel-furnace'].ingredients = { {"stone-furnace", 1}, {"steel-plate", 8}}

    --     name = "electric-furnace",
    --     ingredients = {{"steel-plate", 10}, {"advanced-circuit", 5}, {"stone-brick", 10}},

    data.raw.recipe['electric-furnace'].ingredients = { {"steel-furnace", 1}, {"concrete", 10}, {"advanced-circuit", 5}}
end

------ << Furnace & Drill Progression

------ >> Utility Science
if settingsutil.get_startup_setting("utility-science-pack") then
    -- {
    --     type = "recipe",
    --     name = "utility-science-pack",
    --     enabled = false,
    --     energy_required = 21,
    --     ingredients =
    --     {
    --       {"low-density-structure", 3},
    --       {"processing-unit", 2},
    --       {"flying-robot-frame", 1}
    --     },
    --     result_count = 3,
    --     result = "utility-science-pack"
    -- }

    tableutil.add(data.raw.recipe['utility-science-pack'].ingredients, {"uranium-238", 2} )
end

------ << Utility Science

------ >> Rocket Silo
if settingsutil.get_startup_setting("rocket-silo") then
    -- {
    --     type = "recipe",
    --     name = "rocket-silo",
    --     enabled = false,
    --     ingredients =
    --     {
    --       {"steel-plate", 1000},
    --       {"concrete", 1000},
    --       {"pipe", 100},
    --       {"processing-unit", 200},
    --       {"electric-engine-unit", 200}
    --     },
    --     energy_required = 30,
    --     result = "rocket-silo",
    --     requester_paste_multiplier = 1
    -- }

    data.raw.recipe['rocket-silo'].energy_required = 60

    tableutil.remove(
        data.raw.recipe['rocket-silo'].ingredients,
        function (i) return i and i[1] == "concrete" end)

    tableutil.add(data.raw.recipe['rocket-silo'].ingredients, {"refined-concrete", 1000})
    tableutil.add(data.raw.recipe['rocket-silo'].ingredients, {"programmable-speaker", 1})
end
------ << Rocket Silo