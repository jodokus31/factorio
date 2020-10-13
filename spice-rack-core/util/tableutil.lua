local TableUtil = {}

function TableUtil.add(tbl, value, check_if_exists)
    local index = nil
    if check_if_exists then
        if type(value) ~= "table" then
            index, _ = TableUtil.find(tbl, 
                function(v) return v == value end)
        else
            index, _ = TableUtil.find(tbl, 
                function(v) return type(v) == "table" and util.table.compare(v, value) end)
        end
    end

    if not index then
        table.insert(tbl, value)
    end
end

function TableUtil.remove(tbl, predicate)
    local index, value = TableUtil.find(tbl, predicate)
    if index then
        table.remove(tbl, index)
    end
    return value
end

function TableUtil.find(tbl, predicate)
    if not tbl or not predicate then
        return nil, nil
    end

    for index, value in pairs(tbl) do
        if predicate(value) then
            return index, value
        end
    end
end

return TableUtil
