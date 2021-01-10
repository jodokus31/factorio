local item_decay_defaults = require('item_decay_defaults')

local ItemValues = {}

ItemValues.logger = nil
ItemValues.settingswrapper = nil

function ItemValues.rebuildItemValues()
    global.SpiceRack_ItemValues = {}
end

function ItemValues.readItemValues(itemname)
    local item_values = 
        { 
            count = 0,
            percent = 0,
            stack_size = 0,
            fraction = 0,
        }

    if item_decay_defaults[itemname] ~= nil then
        
        item_values.percent = ItemValues.settingswrapper.getItemPercent(itemname)

        local item_prototype = game.item_prototypes[itemname]
        if item_prototype then
            item_values.stack_size = item_prototype.stack_size
        else
            logger.warn("item_prototype for "..itemname.." is nil.. ")
        end
    end

    return item_values
end

function ItemValues.lookupItemValues(itemname)
    global.SpiceRack_ItemValues[itemname] = global.SpiceRack_ItemValues[itemname] or ItemValues.readItemValues(itemname)
    
    return global.SpiceRack_ItemValues[itemname]
end

return ItemValues
