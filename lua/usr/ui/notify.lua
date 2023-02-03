-- @desc: better notifier
local M = {}

M.opts = {
	timeout = 666,
	max_height = function()
		return math.floor(vim.o.lines * 0.75)
	end,
	max_width = function()
		return math.floor(vim.o.columns * 0.75)
	end,
}

M.api = {
	dismiss = function()
		require("notify").dismiss({
			silent = true,
			pending = true,
		})
	end,
}

M.repo = {
	"rcarriga/nvim-notify",
	opts = M.opts,
	keys = {
		{
			"<Leader>un",
			M.api.dismiss,
			desc = "Dismiss all notification",
		},
	},
}

return M
