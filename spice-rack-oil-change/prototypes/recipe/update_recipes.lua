local settingsutil = require('__spice-rack-core__/util/settingsutil')
local tableutil = require('__spice-rack-core__/util/tableutil')

------ >> Oil Change
if settingsutil.get_startup_setting("oil-change") ~= "disabled" then

    data.raw.recipe['basic-oil-processing'].results = {
        {type="fluid", name="heavy-oil", amount=25, fluidbox_index = 1},
        {type="fluid", name="petroleum-gas", amount=45, fluidbox_index = 3}
    }

    data.raw.recipe['sulfur'].ingredients = {
        {type="fluid", name="water", amount = 30},
        {type="fluid", name="heavy-oil", amount = 10}
    }

    data.raw.recipe['heavy-oil-cracking'].ingredients = 
    {
        {type="fluid", name="steam", amount=30},
        {type="fluid", name="heavy-oil", amount=40}
    }

    data.raw.recipe['light-oil-cracking'].ingredients = 
    {
        {type="fluid", name="steam", amount=30},
        {type="fluid", name="light-oil", amount=30}
    }

    data.raw.recipe['solid-fuel-from-petroleum-gas'].ingredients = 
    {
        {type="fluid", name="petroleum-gas", amount=30}
    }
end
------ << Oil Change