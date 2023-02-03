local M = {}

M.api = {
	next_ref = function()
		require("todo-comments").jump_next()
	end,
	prev_ref = function()
		require("todo-comments").jump_prev()
	end,
}

M.keys = {
	{
		"]t",
		M.api.next_ref,
		desc = "[TODO] Next ref",
	},
	{
		"[t",
		M.api.prev_ref,
		desc = "[TODO] Prev Ref",
	},
	{
		"<Leader>xt",
		"<cmd>TodoTrouble<cr>",
		desc = "Todo (Trouble)",
	},
	{
		"<Leader>xT",
		"<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",
		desc = "Todo/ Fix/ Fixme (Trouble)",
	},
	{
		"<Leader>/t",
		"<cmd>TodoTelescope<cr>",
		desc = "Todo",
	},
}

M.repo = {
	"folke/todo-comments.nvim",
	event = "BufReadPost",
	cmd = { "TodoTrouble", "TodoTelescope" },
	config = true,
	keys = M.keys,
}

return M
