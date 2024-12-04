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

	if #urls == 0 then
		return ya.notify({
			title = "System Clipboard",
			content = "No file selected",
			level = "warn",
			timeout = 5,
		})
	end

	local status, err = Command("cb"):arg("copy"):args(urls):spawn():wait()
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

local function paste()
	local path = cwd()

	-- local status, err = Command("cb"):arg("copy"):args(urls):spawn():wait()
	local command = "cd " .. path .. " && cb paste"
	ya.notify({
		title = "Executing command " .. command,
		content = "",
		level = "info",
		timeout = 2,
	})
	local status, err = Command(command):spawn():wait()

	if status or status.success then
		ya.notify({
			title = "Pasting N items",
			content = string.format("Path: %s", path),
			level = "info",
			timeout = 2,
		})
		return
	end
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
			paste()
		end
	end,
}
