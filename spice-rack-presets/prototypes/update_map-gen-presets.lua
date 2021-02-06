local function make_resource_small_rich(autoplace_controls, resource) 
    if resource == "enemy-base" then
        -- don't change enemies
    elseif resource == "crude-oil" then
        -- don't change oil
    elseif resource == "uranium-ore" then
        autoplace_controls[resource] = {
                frequency = 0.16666666666,
                size = 0.5,
                richness = 2,
            }
    else
        autoplace_controls[resource] = {
                frequency = 0.16666666666,
                size = 1,
                richness = 2,
            }
    end
end
local function create_small_but_rich(template_name, new_name, order)
    
    local small_but_rich = util.table.deepcopy(data.raw["map-gen-presets"].default[template_name])
    
    small_but_rich.order = order
    
    for resource, setting in pairs(small_but_rich.basic_settings.autoplace_controls) do
        make_resource_small_rich(small_but_rich.basic_settings.autoplace_controls, resource)
    end

    data.raw["map-gen-presets"].default[new_name] = small_but_rich
end
local function create_marathon(template_name, new_name, order, mode)
    
    local marathon = util.table.deepcopy(data.raw["map-gen-presets"].default[template_name])
    
    marathon.order = order
    marathon.advanced_settings.difficulty_settings = {
        recipe_difficulty = defines.difficulty_settings.recipe_difficulty.expensive,
        technology_difficulty = defines.difficulty_settings.technology_difficulty.expensive,
        technology_price_multiplier = 4,
        research_queue_setting = "always"
    }

    if mode == "deathworld" then
        marathon.advanced_settings.enemy_evolution.time_factor = 0.000015
        marathon.advanced_settings.enemy_evolution.pollution_factor = 0.0000010
        marathon.advanced_settings.pollution.ageing = 0.5
        marathon.advanced_settings.pollution.enemy_attack_pollution_consumption_modifier = 0.8
    end

    data.raw["map-gen-presets"].default[new_name] = marathon
end

local function create_rail_autoplace_controls(mode)
    local autoplace_controls =
    {
        ["iron-ore"] =
        {
            frequency = 0.16666666666,
            size = 3
        },
        ["copper-ore"] =
        {
            frequency = 0.16666666666,
            size = 3
        },
        coal =
        {
            frequency = 0.16666666666,
            size = 3
        },
        stone =
        {
            frequency = 0.16666666666,
            size = 3
        },
        ["uranium-ore"] =
        {
            frequency = 0.16666666666,
            size = 1
        },
        ["crude-oil"] =
        {
            frequency = 0.16666666666,
            size = 2
        },
        ["enemy-base"] =
        {
            size = 1
        }
    }

    if mode == "deathworld" then
        autoplace_controls["enemy-base"] = 
            { 
                frequency = "very-high", 
                size = "very-big"
            }
    end

    return autoplace_controls
end

data.raw["map-gen-presets"].default["spice-rack-rail-world"] =
    {
        order = "z[spice-rack]-a[rail-world]",
        basic_settings =
        {
            property_expression_names = {},
            autoplace_controls = create_rail_autoplace_controls("normal"),
            terrain_segmentation = 0.5,
            water = 1.5
        },
        advanced_settings =
        {
            enemy_evolution =
            {
                time_factor = 0.000004
            },
            enemy_expansion =
            {
                enabled = false
            },
            difficulty_settings = 
            {
                research_queue_setting = "always"
            },
        }
    }

data.raw["map-gen-presets"].default["spice-rack-death-rail-world"] =
    {
        order = "z[spice-rack]-b[death-rail-world]",
        basic_settings =
        {
            property_expression_names = {},
            autoplace_controls = create_rail_autoplace_controls("deathworld"),
            terrain_segmentation = 0.5,
            water = 1.5
        },
        advanced_settings =
        {
            enemy_evolution =
            {
                time_factor = 0.00002,
                pollution_factor = 0.0000012
            },
            pollution =
            {
                ageing = 0.5,
                enemy_attack_pollution_consumption_modifier = 0.5
            },
            difficulty_settings = 
            {
                research_queue_setting = "always"
            },
        }
    }

create_marathon("spice-rack-rail-world", "spice-rack-rail-world-marathon", "z[spice-rack]-c[rail-world-marathon]", "normal")
create_marathon("spice-rack-death-rail-world", "spice-rack-death-rail-world-marathon", "z[spice-rack]-d[death-rail-world-marathon]", "deathworld")

--------------- >> small but rich

create_small_but_rich("spice-rack-rail-world", "spice-rack-rail-world-sbr", "z[spice-rack]-e[rail-world-sbr]")
create_small_but_rich("spice-rack-death-rail-world", "spice-rack-death-rail-world-sbr", "z[spice-rack]-f[death-rail-world-sbr]")

create_small_but_rich("spice-rack-rail-world-marathon", "spice-rack-rail-world-marathon-sbr", "z[spice-rack]-g[rail-world-marathon-sbr]")
create_small_but_rich("spice-rack-death-rail-world-marathon", "spice-rack-death-rail-world-marathon-sbr", "z[spice-rack]-h[death-rail-world-marathon]")

--------------- << small but rich


