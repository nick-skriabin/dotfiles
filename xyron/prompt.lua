xyron.prompt.configure("git", {
	branch = "\u{e0a0}", --  (nf-pl-branch)
	staged = "\u{f00c}", --  (nf-fa-check)
	modified = "\u{f040}", --  (nf-fa-pencil)
	deleted = "\u{f00d}", --  (nf-fa-times / remove)
	untracked = "\u{f128}", --  (nf-fa-question)
	conflicts = "\u{e009}", --  (nf-iec-power_on / conflict)
	ahead = "\u{f062}", --  (nf-fa-arrow_up)
	behind = "\u{f063}", --  (nf-fa-arrow_down)
	clean = "\u{f00c}", --  (nf-fa-check)
	lines_added = "\u{f055}", --  (nf-fa-plus_circle)
	lines_removed = "\u{f056}", --  (nf-fa-minus_circle)
})

xyron.prompt.configure("cwd", {
	truncate = 2,
})

xyron.prompt.configure("symbol", {
	icon = "",
	icon_vim = "",
})

xyron.prompt.init({
	"cwd",
	" ",
	"git",
	"spacer",
	"xyron_project",
	"\n",
	"symbol",
	" ",
})
