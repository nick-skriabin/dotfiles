local colors = require("colors")

local spaces = {}

function add_workspaces(monitor, focused_workspace, workspaces)
	for ws in split(workspaces) do
		local key = "space" .. monitor .. ws
		local space = sbar.add("space", key, {
			position = "left",
			space = ws,
			icon = {
				string = ws,
				color = colors.text,
				font = {
					size = 14,
					style = "Heavy",
				},
				highlight_color = colors.red,
				padding_left = 6,
				padding_right = 6,
			},
			label = {
				drawing = false,
			},
			background = {
				padding_left = 6,
				padding_right = 6,
			},
			display = monitor,
			padding_left = 0,
			padding_right = 12,
			update_freq = 0.1,
		})

		space:set({ icon = { string = ws } })

		if ws == focused_workspace then
			sbar.set(key, { icon = { highlight = true } })
		end

		table.insert(spaces, space.name)
	end
end

sbar.add("event", "aerospace_workspace_change")

sbar.exec("aerospace list-monitors | awk '{print $1}'", function(monitors)
	for m in split(monitors) do
		sbar.exec("aerospace list-workspaces --monitor " .. m .. " focused --visible", function(focused_workspace)
			sbar.exec("aerospace list-workspaces --monitor " .. m, function(workspaces)
				focused_workspace = string.gsub(focused_workspace, "%s+", "")
				add_workspaces(m, focused_workspace, workspaces)
				local front_app = sbar.add("item", "front-app", {
					icon = {
						drawing = false,
					},
					label = {
						font = {
							style = "Black",
							size = 12.0,
						},
					},
				})

				front_app:subscribe({ "front_app_switched", "forced" }, function(env)
					front_app:set({
						label = {
							string = env.INFO,
						},
					})
				end)
				table.insert(spaces, front_app.name)
			end)
		end)
	end
end)

local bracket = sbar.add("bracket", spaces, {
	position = "left",
	background = {
		color = colors.blue,
	},
})
bracket:subscribe("aerospace_workspace_change", function(env)
	local prev = env.AEROSPACE_PREV_WORKSPACE
	local focused = env.AEROSPACE_FOCUSED_WORKSPACE
	local prev_key = "space" .. 1 .. prev
	local key = "space" .. 1 .. focused

	sbar.set(prev_key, { icon = { highlight = false } })
	sbar.set(key, { icon = { highlight = true } })
end)

function split(str)
	local list = {}
	for s in str:gmatch("[^\r\n]+") do
		table.insert(list, s)
	end
	return pairs(list)
end
