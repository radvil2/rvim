-- @desc: easy motion to comments
local M = {}

M.id = "echasnovski/mini.comment"

M.opts = {
	hooks = {
		pre = function()
			require("ts_context_commentstring.internal").update_commentstring({})
		end,
	},
}

M.dependencies = {
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
	},
}

M.config = function(_, opts)
	require("mini.comment").setup(opts)
end

M.repo = {
	M.id,
	opts = M.opts,
	event = "VeryLazy",
	dependencies = M.dependencies,
	config = M.config,
}

return M
