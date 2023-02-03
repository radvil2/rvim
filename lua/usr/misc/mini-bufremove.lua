local M = {}

M.id = "echasnovski/mini.bufremove"

M.init = function()
	Api.nvim_create_user_command("BD", function()
		require("mini.bufremove").delete(0, false)
	end, { desc = "Save remove buffer" })

	Api.nvim_create_user_command(
		"BDA",
		"bufdo lua require('mini.bufremove').delete()",
		{ desc = "Save remove all buffers" }
	)
end

M.keys = {
	{
		"<Leader>bd",
		"<Cmd>BD<Cr>",
		desc = "Delete current buffer",
	},
	{
		"<Leader>bD",
		"<Cmd>BDA<Cr>",
		desc = "Delete all buffers",
	},
}

M.repo = {
	M.id,
	version = false, -- key up with the stable branch
	init = M.init,
	keys = M.keys,
}

return M
