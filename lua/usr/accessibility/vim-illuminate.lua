local M = {}

M.id = "RRethy/vim-illuminate"

M.api = {
	prev_ref = function()
		require("illuminate").goto_prev_reference(false)
	end,
	next_ref = function()
		require("illuminate").goto_next_reference(false)
	end,
}

M.keys = {
	{
		"<A-p>",
		M.api.prev_ref,
		desc = "Prev Reference",
	},
	{
		"<A-n>",
		M.api.next_ref,
		desc = "Next Reference",
	},
}

M.opts = {
	delay = 200,
	filetypes_denylist = {
		"TelescopePrompt",
		"lspsagaoutline",
		"lspsagafinder",
		"Dashboard",
		"NvimTree",
		"fugitive",
		"dirvish",
		"html",
	},
}

M.config = function(_, opts)
	local illuminate = Call("illuminate")
	if not illuminate then
		vim.notify("Illuminate was not installed properly!", vim.log.levels.ERROR)
		return
	end

	illuminate.configure(opts)

	Api.nvim_create_autocmd("FileType", {
		callback = function()
			local buffer = Api.nvim_get_current_buf()
			pcall(vim.keymap.del, "n", "<A-n>", { buffer = buffer })
			pcall(vim.keymap.del, "n", "<A-p>", { buffer = buffer })
		end,
	})

	Log("/usr/accessibility/illuminate", "CONFIG")
end

M.repo = {
	M.id,
	enabled = Env.finder.illuminate.enable,
	event = "BufReadPost",
	opts = M.opts,
	keys = M.keys,
	config = M.config,
}

return M
