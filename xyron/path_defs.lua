function setpath(path)
	xyron.setenv("PATH", path .. ":" .. xyron.getenv("PATH"))
end

local home = xyron.getenv("HOME")

setpath(home .. "/bin")
setpath(home .. "/.cargo/bin")
setpath(home .. "/.cargo/env")
setpath(home .. "/.local/bin")
setpath(home .. "/.local/sbin")
setpath(home .. "/.yarn/bin")
setpath(home .. "/.opencode/bin")
setpath("/usr/local/bin")
setpath("/opt/local/bin")
setpath("/opt/local/sbin")
setpath("/opt/homebrew/bin")
setpath("/run/current-system/sw/bin")
