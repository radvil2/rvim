-- @desc: better diagnostics list and others
local M = {}

M.id = "folke/trouble.nvim"

M.opts = { use_diagnostic_signs = true }

M.keys = {
	{
		"<Leader>xx",
		"<Cmd>TroubleToggle document_diagnostics<cr>",
		desc = "Document Diagnostics (Trouble)",
	},
	{
		"<Leader>xX",
		"<Cmd>TroubleToggle workspace_diagnostics<Cr>",
		desc = "Workspace Diagnostics (Trouble)",
	},
}

M.repo = {
	M.id,
	opts = M.opts,
	keys = M.keys,
	cmd = {
		"TroubleToggle",
		"Trouble",
	},
}

return M
