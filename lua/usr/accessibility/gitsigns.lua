-- @desc: git signs indicator
local M = {}

M.id = "lewis6991/gitsigns.nvim"

local signs = {
	add = { text = "▎" },
	change = { text = "▎" },
	delete = { text = "契" },
	topdelete = { text = "契" },
	changedelete = { text = "▎" },
	untracked = { text = "▎" },
}

M.opts = {
	signs = signs,
	on_attach = function(buffer)
		local gs = package.loaded.gitsigns
		local opts = { buffer = buffer }

		Map("n", "]h", gs.next_hunk, Merge(opts, { desc = "Next Hunk" }))
		Map("n", "[h", gs.prev_hunk, Merge(opts, { desc = "Prev Hunk" }))

		-- TODO: Learn all mechanism first
		-- map({ "n", "v" }, "<Leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
		-- map({ "n", "v" }, "<Leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
		-- map("n", "<Leader>ghS", gs.stage_buffer, "Stage Buffer")
		-- map("n", "<Leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
		-- map("n", "<Leader>ghR", gs.reset_buffer, "Reset Buffer")
		-- map("n", "<Leader>ghp", gs.preview_hunk, "Preview Hunk")
		-- map("n", "<Leader>ghb", function()
		--   gs.blame_line({ full = true })
		-- end, "Blame Line")
		-- map("n", "<Leader>ghd", gs.diffthis, "Diff This")
		-- map("n", "<Leader>ghD", function()
		--   gs.diffthis("~")
		-- end, "Diff This ~")
		-- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
	end,
}

M.repo = {
	M.id,
	event = "BufReadPre",
	opts = M.opts,
}

return M
