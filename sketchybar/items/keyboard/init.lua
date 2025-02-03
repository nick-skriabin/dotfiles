local input = sbar.add("item", {
	position = "right",
	icon = {
		drawing = false,
	},
	padding_left = 12,
	width = 35,
	label = {
		font = {
			style = "Semibold",
		},
	},
})

sbar.add("event", "keyboard_change", "AppleSelectedInputSourcesChangedNotification")

input:subscribe({ "routine", "forced", "keyboard", "keyboard_change" }, function()
	sbar.exec(
		[[defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "KeyboardLayout Name" | sed -e "s/[\" ;]//g" | awk -F '=' '{print $2}']],
		function(result)
			local layout_name = string.gsub(result, "%s+", "")
			print("'" .. layout_name .. "'")
			local layout = "한"
			if layout_name == "U.S." then
				layout = "US"
			elseif layout_name == "RussianWin" then
				layout = "RU"
			elseif layout_name == "ColemakDHANSI" then
				layout = "CO"
			elseif layout_name == "Graphite" then
				layout = "GR"
			end
			input:set({ label = { string = layout } })
		end
	)
end)
