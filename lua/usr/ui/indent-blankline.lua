-- @desc: indentation guide
local M = {}

M.opts = {
	char = "│",
	show_trailing_blankline_indent = false,
	show_current_context = false,
	filetype_exclude = {
		"dashboard",
		"neo-tree",
		"Trouble",
		"alpha",
		"lazy",
		"help",
	},
}

M.repo = {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPost",
	opts = M.opts,
}

return M
