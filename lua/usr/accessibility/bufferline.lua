local M = {}
local env = Env.editor.bufferline

M.id = "akinsho/nvim-bufferline.lua"

M.dependencies = { "nvim-tree/nvim-web-devicons" }

M.keys = {
	{
		"<A-b>",
		"<Cmd>BufferLinePick<CR>",
		desc = "Pick buffer",
	},
	{
		"<A-[>",
		"<Cmd>BufferLineMovePrev<CR>",
		desc = "Move buffer to the left",
	},
	{
		"<A-]>",
		"<Cmd>BufferLineMoveNext<CR>",
		desc = "Move buffer to the right",
	},
	{
		"<A-,>",
		"<Cmd>BufferLineCyclePrev<CR>",
		desc = "Switch to buffer left",
	},
	{
		"<A-.>",
		"<Cmd>BufferLineCycleNext<CR>",
		desc = "Switch to buffer right",
	},
}

M.opts = {
	options = {
		diagnostics = "nvim_lsp",
		separator_style = env.style or "slant",
		show_tab_indicators = env.show_indicators or false,
		show_close_icon = env.show_buffer_close or false,
		-- can be a string | function, see "Mouse actions"
		-- close_command = "Bdelete",
		indicator = { style = "icon" },
		offsets = {
			{
				text = require("media.icons").Misc.Vim .. " NvimTree",
				highlight = "Directory",
				filetype = "NvimTree",
				text_align = "left",
			},
		},
	},
}

M.repo = {
	M.id,
	dependencies = M.dependencies,
	enabled = env.enable,
	opts = M.opts,
	keys = M.keys,
}

return M
