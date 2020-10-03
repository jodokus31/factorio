local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Effectivity Modules
if settingsutil.get_startup_setting("effectivity-modules-rebalance") then
    -- name = "electric-mining-drill",
    -- module_specification =
    --     {
    --       module_slots = 3
    --     },
    data.raw['mining-drill']['electric-mining-drill'].module_specification.module_slots = 2
end
------ << Effectivity Modules

------ >> Furnace & Drill Progression
if settingsutil.get_startup_setting("furnace-drill-change") then
    -- name = "burner-mining-drill",
    -- energy_source =
    -- {
    --     emissions_per_minute = 12,
    -- },
    -- energy_usage = "150kW",

    data.raw['mining-drill']['burner-mining-drill'].energy_usage = "240kW"
    data.raw['mining-drill']['burner-mining-drill'].energy_source.emissions_per_minute = 16

    -- name = "stone-furnace",
    -- energy_source =
    -- {
    --     emissions_per_minute = 2,
    -- }
    -- energy_usage = "90kW"

    data.raw['furnace']['stone-furnace'].energy_usage = "150kW"
    data.raw['furnace']['stone-furnace'].energy_source.emissions_per_minute = 2.5

    -- name = "steel-furnace",
    -- energy_usage = "90kW"
    -- energy_source =
    -- {
    --     emissions_per_minute = 4,
    -- }

    data.raw['furnace']['steel-furnace'].energy_usage = "225kW"
    data.raw['furnace']['steel-furnace'].energy_source.emissions_per_minute = 4

    -- name = "electric-furnace",
    -- crafting_speed = 2,
    -- energy_usage = "180kW",
    -- energy_source =
    --     {
    --       emissions_per_minute = 1
    --     }
    -- module_specification =
    -- {
    --     module_slots = 2,
    --     module_info_icon_shift = {0, 0.8}
    -- },

    data.raw['furnace']['electric-furnace'].energy_usage = "400kW"
    data.raw['furnace']['electric-furnace'].crafting_speed = 3
    data.raw['furnace']['electric-furnace'].energy_source.emissions_per_minute = 1.5
    data.raw['furnace']['electric-furnace'].module_specification.module_slots = 3
end
------ << Furnace & Drill Progression