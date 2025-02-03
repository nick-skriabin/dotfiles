local colors = require("colors")
local settings = require("settings")

sbar.default({
	icon = {
		color = colors.text,
		font = {
			family = settings.nerd_font,
			style = "Bold",
			size = 16.0,
		},
		padding_left = "$PADDINGS",
		padding_right = "$PADDINGS",
	},
	label = {
		color = colors.text,
		font = {
			family = settings.font,
			style = "Regular",
			size = 13.0,
		},
		padding_left = "$PADDINGS",
		padding_right = "$PADDINGS",
	},
})
