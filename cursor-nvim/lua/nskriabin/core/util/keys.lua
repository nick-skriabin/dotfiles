local keys = function(t)
    local res = {}
    for k, _ in pairs(t) do
        table.insert(res, k)
    end
    return res
end

return keys
