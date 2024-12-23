function async_notifications(icons)
    -- local co = coroutine.create(
    --     --- @returns string
    --     function()
    --         local result = ""
    --         local handle = vim.loop.new_timer()
    --
    --         handle:start(
    --             0,
    --             0,
    --             vim.schedule_wrap(function()
    --                 result = vim.fn.system('gh notify -e "review" -n 50 -p -s -e "CI/CD" | awk -F " +" \'{print $7}\'')
    --                 print(result)
    --                 handle:stop()
    --                 handle:close()
    --             end)
    --         )
    --         return result
    --     end
    -- )
    -- local success, statuses = coroutine.resume(co)
    local success = true
    local statuses = "hello\nworld"
    vim.fn.notify("hello", "info")

    if success ~= true then
        return "Network error"
    end

    local new = icons.misc.notifications_new
    local empty = icons.misc.notifications
    local counters = {}

    if statuses == nil then
        return empty .. " No notifications"
    end

    for s in statuses:gmatch("[^\r\n]+") do
        if counters[s] == nil then
            counters[s] = 1
        else
            counters[s] = counters[s] + 1
        end
    end
    print(statuses)
    print(dump(counters))
    return new .. "  notifications"
end

return function(palette, icons)
    return {
        function()
            vim.notify("start", "info")
            return "hello there"
            -- -- Show last 10 notification that are review requests
            -- -- Excluding CI notifications
            -- -- Grabbing statuses
            -- return async_notifications()
        end,
        icon = icons.misc.recording,
        color = { fg = palette.text },
        padding = { left = 1, right = 1 },
        refresh = 10000,
    }
end
