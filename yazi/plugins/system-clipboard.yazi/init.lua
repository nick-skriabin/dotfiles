-- Meant to run at async context. (yazi system-clipboard)

local selected_or_hovered = ya.sync(function()
    local tab, paths = cx.active, {}
    for _, u in pairs(tab.selected) do
        paths[#paths + 1] = tostring(u)
    end
    if #paths == 0 and tab.current.hovered then
        paths[1] = tostring(tab.current.hovered.url)
    end
    return paths
end)

local cwd = ya.sync(function()
    local tab, _ = cx.active, {}
    return tostring(tab.current.cwd)
end)

local function copy_file()
    ya.manager_emit("escape", { visual = true })

    local urls = selected_or_hovered()
    log_notify(urls)

    if #urls == 0 then
        return ya.notify({
            title = "System Clipboard",
            content = "No file selected",
            level = "warn",
            timeout = 5,
        })
    end

    local status, err = Command("cb"):args({ "copy", urls }):spawn():wait()
    local success = status or status.success

    if success then
        ya.notify({
            title = "System Clipboard",
            content = "Succesfully copied the file(s) to system clipboard",
            level = "info",
            timeout = 5,
        })
        return
    end

    ya.notify({
        title = "System Clipboard",
        content = string.format("Could not copy selected file(s) %s", status and status.code or err),
        level = "error",
        timeout = 5,
    })
end

function log_notify(message)
    ya.notify({
        title = "Message",
        content = message,
        level = "warn",
        timeout = 5,
    })
end

local function paste()
    ya.dbg("start")
    local path = cwd()
    local child, err = Command("cb"):arg("paste"):cwd(path):stdout(Command.PIPED):output()
    local success = child or child.success

    if success then
        ya.dbg("pasted")
        return
    end

    ya.err("fail")
end

return {
    entry = function(_, args)
        local action = args[1]
        if not action then
            return
        end
        if action == "copy" then
            copy_file()
        end

        if action == "paste" then
            ya.dbg("paste")
            paste()
        end
    end,
}
