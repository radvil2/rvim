local M = {}

M.id = "folke/persistence.nvim"

M.opts = {
	options = {
		"buffers",
		"tabpages",
		"winsize",
		"curdir",
		"help",
	},
}

M.api = {
	restore_session = function()
		require("persistence").load()
	end,

	restore_last_session = function()
		require("persistence").load({ last = true })
	end,

	stop_session_saving = function()
		require("persistence").stop()
	end,
}

M.keys = {
	{
		"<Leader>Sr",
		M.api.restore_session,
		desc = "Restore Session",
	},
	{
		"<Leader>Sl",
		M.api.restore_last_session,
		desc = "Restore Last Session",
	},
	{
		"<Leader>Ss",
		M.api.stop_session_saving,
		desc = "Don't Save Current Session",
	},
}

M.repo = {
	M.id,
	event = "BufReadPre",
	opts = M.opts,
	keys = M.keys,
}

return M
