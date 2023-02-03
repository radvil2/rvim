local M = {}

local env = Env.theme
local flavour = env.colorvariant or "mocha"
local transbg = env.transparentbg

if not env.darkmode then
	flavour = "latte"
	transbg = false
end

M.opts = {
	transparent_background = transbg,
	term_colors = true,
	dim_inactive = {
		percentage = 0.15,
		enabled = false,
		shade = "dark",
	},
	background = {
		light = "latte",
		dark = "mocha",
	},
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
	},
	integrations = {
		treesitter = true,
		coc_nvim = false,
		lsp_trouble = true,
		cmp = true,
		lsp_saga = true,
		leap = true, -- test
		gitgutter = false,
		gitsigns = true,
		telescope = true,
		which_key = false,
		dashboard = true,
		neogit = false,
		vim_sneak = false,
		fern = false,
		barbar = false,
		bufferline = true,
		markdown = true,
		lightspeed = false,
		ts_rainbow = true,
		hop = true,
		notify = true,
		telekasten = true,
		symbols_outline = true,
		mini = false,
		navic = false,
	},
	nvimtree = {
		enabled = true,
		show_root = false,
		transparent_panel = transbg,
	},
	dap = {
		enabled = false,
		enable_ui = false,
	},
	indent_blankline = {
		colored_indent_levels = false,
		enabled = true,
	},
	native_lsp = {
		enabled = true,
		virtual_text = {
			errors = { "italic" },
			hints = { "italic" },
			warnings = { "italic" },
			information = { "italic" },
		},
		underlines = {
			errors = { "underline" },
			hints = { "underline" },
			warnings = { "underline" },
			information = { "underline" },
		},
	},
}

if transbg then
	local colors = require("catppuccin.palettes").get_palette()
	local user_colors = require("media.colors").palette

	colors.none = "NONE"

	M.opts.custom_highlights = {
		Comment = {
			fg = colors.overlay1,
		},
		LineNr = {
			fg = colors.overlay1,
		},
		DiagnosticVirtualTextError = {
			bg = colors.none,
			fg = user_colors.red,
		},
		DiagnosticVirtualTextWarn = {
			bg = colors.none,
			fg = user_colors.yellow,
		},
		DiagnosticVirtualTextInfo = {
			bg = colors.none,
		},
		DiagnosticVirtualTextHint = {
			bg = colors.none,
		},
	}

	if flavour == "mocha" then
		M.opts.custom_highlights = Merge(M.opts.custom_highlights, {
			TelescopeBorder = {
				fg = user_colors.yellow,
			},
			BufferLineErrorSelected = {
				fg = user_colors.red,
				bold = true,
			},
			BufferLineWarningSelected = {
				fg = user_colors.yellow,
				bold = true,
			},
			BufferLineInfoSelected = {
				fg = user_colors.cyan,
				bold = true,
			},
			NvimTreePopup = {
				fg = user_colors.yellow,
			},
			NvimTreeFolderIcon = {
				fg = user_colors.yellow,
			},
			NvimTreeFolderName = {
				fg = user_colors.fg,
			},
			NavicText = {
				fg = user_colors.cyan,
			},
			NavicSeparator = {
				fg = "#8087A2",
			},
		})
	end
end

M.repo = {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = env.colorscheme ~= "catppuccin",
	config = function()
		local catppuccin = Call("catppuccin")
		if not catppuccin then
			vim.notify("catpuccin was not installed!", vim.log.levels.ERROR)
			return
		end
		catppuccin.setup(M.opts)
		vim.g.catppuccin_flavour = flavour
		if env.colorscheme == "catppuccin" then
			vim.cmd("colorscheme catppuccin")
		end
	end,
}

return M
