-- @desc: auto pairs
local M = {}

M.repo = {
	"echasnovski/mini.pairs",
	event = "VeryLazy",
	config = function(_, opts)
		require("mini.pairs").setup(opts)
	end,
}

return M
