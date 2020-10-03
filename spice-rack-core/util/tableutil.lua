local TableUtil = {}

function TableUtil.add(tbl, value)
    table.insert(tbl, value)
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
        return nil
    end

    for index, value in pairs(tbl) do
        if predicate(value) then
            return index, value
        end
    end
end

return TableUtil
