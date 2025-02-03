local cal = sbar.add("item", {
	icon = {
		padding_right = 0,
	},
	label = {
		align = "right",
	},
	padding_left = 12,
	position = "right",
	update_freq = 15,
})

local function update()
	local date = os.date("%a. %d %b.")
	local time = os.date("%H:%M")
	cal:set({ label = date .. " " .. time })
end

cal:subscribe("routine", update)
cal:subscribe("forced", update)
