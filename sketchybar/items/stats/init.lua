local icons = require("icons")
local colors = require("colors")

function add_stat(options)
	local stat = sbar.add("item", {
		position = "right",
		background = {
			padding_left = 0,
		},
		label = {
			font_style = "Heavy",
			padding_left = 6,
		},
		icon = {
			string = options.icon,
			color = options.color,
		},
		padding_left = 12,
		padding_right = 12,
		update_freq = 60,
	})

	stat:subscribe({ "routine", "forced" }, options.script(stat))
	return stat
end

add_stat({
	color = colors.green,
	icon = icons.cpu,
	script = function(stat)
		return function()
			local cpu_info = sbar.exec(
				[[
      CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
      CPU_INFO=$(ps -eo pcpu,user)
      CPU_SYS=$(echo "$CPU_INFO" | grep -v $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
      CPU_USER=$(echo "$CPU_INFO" | grep $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
      RESULT=$(echo "$CPU_SYS $CPU_USER" | awk '{printf "%.0f\n", ($1 + $2)*100}')

      echo $RESULT
  ]],
				function(result)
					stat:set({ label = { string = result .. "%" } })
				end
			)
		end
	end,
})

add_stat({
	icon = icons.memory,
	color = colors.green,
	script = function(stat)
		return function()
			local mem = sbar.exec(
				[[memory_pressure | grep "System-wide memory free percentage:" | awk '{ printf("%2.0f\n", 100-$5"%") }']],
				function(result)
					stat:set({ label = { string = result .. "%" } })
				end
			)
		end
	end,
})

add_stat({
	icon = icons.disk,
	color = colors.maroon,
	script = function(stat)
		return function()
			sbar.exec([[df -H | grep -E '^(/dev/disk3s5).' | awk '{ printf ("%s\n", $5) }']], function(result)
				stat:set({ label = { string = result } })
			end)
		end
	end,
})
