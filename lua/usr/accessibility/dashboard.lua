local M = {}

M.id = "glepnir/dashboard-nvim"

M.opts = {
	theme = "doom",
	hide = {
		statusline = true,
		tabline = true,
		winbar = true,
	},
	config = {
		header = require("media.ascii-arts").Default,
		footer = {
			"                       ",
			"                       ",
			"🔥 WELCOME BACK FUCKER!",
		},
		center = {
			{
				key = "M",
				icon = "  ",
				desc = "Manage Plugin                            ",
				desc_hi = "DashboardCenter",
				action = "Lazy update",
			},
			{
				key = "O",
				icon = "📁 ",
				desc = "Open recent files                        ",
				desc_hi = "DashboardCenter",
				-- action = 'lua require("usr.finder.rc.telescope").find_oldfiles()', TODO:
				action = "Telescope find_files",
			},
			{
				key = "F",
				icon = "🔎 ",
				desc = "Find files                               ",
				desc_hi = "DashboardCenter",
				action = 'lua require("usr.finder.rc.telescope").find_files()',
			},
			{
				key = ".",
				icon = "🔧 ",
				desc = "Open dotfiles                            ",
				desc_hi = "DashboardCenter",
				action = 'lua require("usr.finder.rc.telescope").find_dotfiles()',
			},
			{
				key = "R",
				icon = "👻 ",
				desc = "Restore session                          ",
				desc_hi = "DashboardCenter",
				action = 'lua require("usr.misc.persistence").api.restore_session()',
			},
		},
	},
}

M.repo = {
	M.id,
	event = "VimEnter",
	opts = M.opts,
}

return M
