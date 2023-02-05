local icons = require("media.icons")
local palette = require("media.colors").palette
local vmodecolor = require("media.colors").vim_mode
local utils = require("usr.ui.lualine.utils")
local default_hl = Api.nvim_get_hl_by_name("TabLineFill", true)
local env = Env.editor.statusline
local bgcolor = palette.bg

if default_hl.background ~= nil then
	bgcolor = string.format("#%06x", default_hl.background)
end

local M = {}

M.options = {
	disabled_filetypes = env.disabled_filetypes,
	globalstatus = env.is_global or false,
	component_separators = "",
	section_separators = "",
	icons_enabled = true,
	theme = "auto",
}

M.sections = {
	lualine_a = {},
	lualine_b = {},
	lualine_y = {},
	lualine_z = {},
	lualine_c = {},
	lualine_x = {},
}

M.inactive_sections = {
	lualine_a = {},
	lualine_b = {},
	lualine_y = {},
	lualine_z = {},
	lualine_c = {},
	lualine_x = {},
}

local function insert_left(changes)
	table.insert(M.sections.lualine_c, changes or {})
end

local function insert_right(changes)
	table.insert(M.sections.lualine_x, changes or {})
end

insert_left({
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

insert_left({
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
insert_left({
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

insert_left({
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

insert_left({
	"filesize",
	cond = IsBufferNotEmpty,
	padding = { right = 1, left = 1, },
	color = { fg = palette.blue, },
	fmt = function(filesize)
		return "🧷 " .. filesize .. " "
	end,
})

insert_left({
	"diagnostics",
	sources = { "nvim_diagnostic", },
	symbols = {
		error = icons.Diagnostics.Error,
		warn = icons.Diagnostics.Warn,
		info = icons.Diagnostics.Info,
	},
	diagnostics_color = {
		color_error = { fg = palette.red, },
		color_info = { fg = palette.cyan, },
		color_warn = { fg = palette.yellow, },
	},
})

-- middle separator
insert_left({
	function()
		return "%="
	end,
})

insert_right({
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
insert_right({
	function()
		return utils.get_server_names() --TODO: recreate this func
	end,
	fmt = function(serverName)
		-- return "🚀 ≪ " .. serverName .. " ≫"
		return "🔸 " .. serverName .. " 🔸"
	end,
	color = {
		fg = palette.blue,
	},
})

insert_right({
	"diff",
	cond = IsGitWorkspace,
	symbols = {
		added = icons.Git.Untracked .. " ",
		modified = icons.Git.Unstaged .. " ",
		removed = icons.Git.Deleted .. " ",
	},
	diff_color = {
		added = { fg = palette.green, },
		modified = { fg = palette.yellow, },
		removed = { fg = palette.red, },
	},
})

insert_right({
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

insert_right({
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

insert_right({
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

return M
