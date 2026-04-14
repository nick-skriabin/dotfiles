-- Load nvm's default node into PATH on startup
local nvm_dir = xyron.getenv("NVM_DIR") or (os.getenv("HOME") .. "/.nvm")
local nvm_sh = nvm_dir .. "/nvm.sh"

-- Load nvm PATH after prompt renders
xyron.defer(function()
	xyron.source(nvm_sh, { vars = { "PATH" } })
end)

-- Single bash call: source + run command + capture PATH
xyron.command("nvm", function(args)
	xyron.source(nvm_sh, {
		run = "nvm " .. table.concat(args, " "),
		vars = { "PATH" },
	})
end)
