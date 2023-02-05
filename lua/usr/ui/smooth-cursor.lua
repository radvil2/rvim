-- @author: gen740
-- @ref: https://github.com/gen740/config.nvim/blob/main/lua/plugins/smoothcursor.lua
local M = {}

M.opts = {
	disable_float_win = true,
	-- flyin_effect = 'bottom',
	flyin_effect = nil,
	autostart = true,
	priority = 100,
	intervals = 22,
	threshold = 1,
	type = "exp",
	speed = 18,
	fancy = {
		enable = true,
		head = {
			texthl = "SmoothCursorHead",
			cursor = "",
		},
		body = {
			{
				cursor = "",
				texthl = "SmoothCursorRed",
			},
			{
				cursor = "",
				texthl = "SmoothCursorOrange",
			},
			{
				cursor = "●",
				texthl = "SmoothCursorYellow",
			},
			{
				cursor = "●",
				texthl = "SmoothCursorGreen",
			},
			{
				cursor = "•",
				texthl = "SmoothCursorAqua",
			},
			{
				cursor = ".",
				texthl = "SmoothCursorBlue",
			},
			{
				cursor = ".",
				texthl = "SmoothCursorPurple",
			},
		},
		tail = {
			texthl = "SmoothCursor",
			cursor = nil,
		},
	},
}

M.repo = {
	dir = Env.path.home .. "/forks/smooth-cursor.nvim",
	event = "BufReadPre",
	opts = M.opts,
}

return M
