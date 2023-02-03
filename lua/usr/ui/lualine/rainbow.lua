local M = {}

local icons = require("media.icons")
local palette = require("media.colors").palette
local vmodecolor = require("media.colors").vim_mode
local utils = require("usr.editor.lualine._utils")
local default_hl = vim.api.nvim_get_hl_by_name("TabLineFill", true)
local env = Env.editor.statusline
local bgcolor = palette.bg

if default_hl.background ~= nil then
	bgcolor = string.format("#%06x", default_hl.background)
end

M.opts = {
	options = {
		disabled_filetypes = env.disabled_filetypes,
		globalstatus = env.is_global or false,
		component_separators = "",
		section_separators = "",
		icons_enabled = true,
		theme = "auto",
	},
	sections = {
		lualine_c = {},
		lualine_x = {},
	},
}

M.sections = {
	left = {},
	right = {},
}

table.insert(M.sections.left, {
	"mode",
	fmt = function(str)
		return icons.Misc.Vim .. str
	end,
	color = function()
		return {
			bg = vmodecolor[vim.fn.mode()],
			fg = bgcolor,
			gui = "bold",
		}
	end,
})

table.insert(M.sections.left, {
	function()
		return icons.Chevron.RightBigFilled
	end,
	padding = 0,
	color = function()
		return {
			fg = vmodecolor[vim.fn.mode()],
			bg = palette.yellow,
		}
	end,
})

-- Git Branch
table.insert(M.sections.left, {
	"branch",
	icon = icons.Common.Git,
	color = {
		bg = palette.yellow,
		fg = bgcolor,
		gui = "bold",
	},
	fmt = function(str)
		if str == "" or str == nil then
			return "!= vcs"
		end
		return str
	end,
})

table.insert(M.sections.left, {
	"filename",
	padding = 0,
	cond = IsBufferNotEmpty,
	fmt = function(filename)
		local icon = icons.Common.File
		local color = palette.green

		if require("nvim-web-devicons").has_loaded() then
			local ext = vim.fn.expand("%:e")
			icon, color = require("nvim-web-devicons").get_icon_color(filename, ext)
		end

		SetHl("StatusLineFileIconPrefix", {
			fg = palette.yellow,
			bg = color,
		})

		SetHl("StatusLineFileIcon", {
			fg = bgcolor,
			bg = color,
		})

		SetHl("StatusLineFileIconSuffix", {
			fg = color,
			bg = palette.green,
		})

		SetHl("StatusLineFileName", {
			fg = bgcolor,
			bg = palette.green,
			bold = true,
		})

		SetHl("StatusLineFileNameSuffix", {
			fg = palette.green,
			bg = bgcolor,
		})

		local ft_icon_prefix = "%#StatusLineFileIconPrefix#" .. icons.Chevron.RightBigFilled
		local ft_icon = "%#StatusLineFileIcon# " .. icon
		local ft_icon_suffix = " %#StatusLineFileIconSuffix#" .. icons.Chevron.RightBigFilled
		local ft_name = "%#StatusLineFileName# " .. filename .. " "
		local ft_name_suffix = "%#StatusLineFileNameSuffix#" .. icons.Chevron.RightBigFilled .. "%*"

		return ft_icon_prefix .. ft_icon .. ft_icon_suffix .. ft_name .. ft_name_suffix
	end,
})

table.insert(M.sections.left, {
	"filesize",
	cond = IsBufferNotEmpty,
	padding = {
		right = 1,
		left = 1,
	},
	color = {
		fg = palette.blue,
	},
	fmt = function(filesize)
		return "🧷 " .. filesize .. " "
	end,
})

table.insert(M.sections.left, {
	"diagnostics",
	sources = {
		"nvim_diagnostic",
	},
	symbols = {
		error = icons.Diagnostics.Error,
		warn = icons.Diagnostics.Warn,
		info = icons.Diagnostics.Info,
	},
	diagnostics_color = {
		color_error = {
			fg = palette.red,
		},
		color_warn = {
			fg = palette.yellow,
		},
		color_info = {
			fg = palette.cyan,
		},
	},
})

table.insert(M.sections.left, {
	function()
		return "%="
	end,
})

table.insert(M.sections.right, {
	"lsp_progress",
	display_components = {
		"lsp_client_name",
		"spinner",
		-- { "title", "percentage", "message" },
	},
	spinner_symbols = icons.SpinnerFrames,
	color = {
		fg = palette.yellow,
		bg = palette.trans,
	},
})

-- Attached Lsp server's name
table.insert(M.sections.right, {
	function()
		return utils.get_server_names()
	end,
	fmt = function(serverName)
		-- return "🚀 ≪ " .. serverName .. " ≫"
		return "🔸 " .. serverName .. " 🔸"
	end,
	color = {
		fg = palette.blue,
	},
})

table.insert(M.sections.right, {
	"diff",
	symbols = {
		added = icons.Git.Untracked .. " ",
		modified = icons.Git.Unstaged .. " ",
		removed = icons.Git.Deleted .. " ",
	},
	diff_color = {
		added = {
			fg = palette.green,
		},
		modified = {
			fg = palette.yellow,
		},
		removed = {
			fg = palette.red,
		},
	},
	cond = IsGitWorkspace,
})

table.insert(M.sections.right, {
	"progress",
	padding = 0,
	color = {
		fg = palette.green,
		gui = "bold",
	},
	fmt = function(progress)
		return " " .. progress .. " "
	end,
})

table.insert(M.sections.right, {
	"location",
	padding = 0,
	color = {
		gui = "bold",
		fg = palette.yellow,
	},
	fmt = function(location)
		return " " .. location .. " "
	end,
})

table.insert(M.sections.right, {
	function()
		return icons.Common.Block
	end,
	padding = 0,
	color = function()
		return {
			fg = vmodecolor[vim.fn.mode()],
		}
	end,
})

-- for _, left_component in ipairs(M.sections.left) do
-- 	table.insert(M.opts.sections.lualine_c, left_component)
-- end
--
-- for _, right_component in ipairs(M.sections.right) do
-- 	table.insert(M.opts.sections.lualine_x, right_component)
-- end
M.opts.sections.lualine_c = M.sections.left
M.opts.sections.lualine_x = M.sections.right

return M
