local M = {}
local env = Env.theme
local variant = env.colorvariant or "storm"
local darkmode = env.darkmode
local bgtrans = env.transparentbg

if not darkmode then
	variant = "day"
end

M.opts = {
	style = variant,
	italic_functions = false,
	terminal_colors = true,
	italic_comments = true,
	italic_keywords = false,
	italic_variables = false,
	transparent = bgtrans,
	hide_inactive_statusline = true,
	transparent_sidebar = bgtrans,
	dark_sidebar = true,
	dark_float = true,
	day_brightness = 0.3,
	lualine_bold = true,
	styles = {
		comments = "italic",
		keywords = "italic",
		functions = "NONE",
		variables = "NONE",
		sidebars = "normal",
		floats = "normal",
	},
	tokyonight_sidebars = {
		"qf",
		"packer",
		"terminal",
		"vista_kind",
	},
}

if bgtrans then
	M.opts.styles.sidebars = "transparent"
	M.opts.styles.floats = "transparent"
	M.opts.on_colors = function(colors)
		colors.error = "#ff0000"
	end
	M.opts.on_highlights = function(hl, colors)
		if not bgtrans then
			return
		end
		local user_colors = require("media.colors").palette
		hl.TelescopeNormal = {
			fg = colors.fg_dark,
			bg = "NONE",
		}
		hl.TelescopeBorder = {
			fg = user_colors.yellow,
			bg = user_colors.bg,
		}
	end
end

M.repo = {
	"folke/tokyonight.nvim",
	lazy = env.colorscheme ~= "tokyonight",
	config = function()
		local tokyonight = Call("tokyonight")
		if not tokyonight then
			vim.notify("tokyonight was not installed!", vim.log.levels.ERROR)
			return
		end
		tokyonight.setup(M.opts)
		if env.colorscheme == "tokyonight" then
			vim.cmd("colorscheme tokyonight")
		end
	end,
}

return M
