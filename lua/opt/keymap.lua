-- This file should load before plugins
local util = require("utils")

-- Base
Map("n", "<Leader>xl", "<Cmd>lopen<Cr>", { desc = "Open Location List" })
Map("n", "<Leader>xq", "<Cmd>copen<Cr>", { desc = "Open Quickfix List" })
Map("n", ";", ":", { nowait = true, silent = false })
Map("v", ";", ":", { nowait = true, silent = false })
Map("n", "+", "<Cmd>join<Cr>", { nowait = true })
Map("n", "U", "<C-r>", { nowait = true })
Map("n", "H", "^")
Map("n", "J", "5j")
Map("n", "K", "5k")
Map("n", "L", "g_")
Map("v", "H", "^")
Map("v", "J", "5j")
Map("v", "K", "5k")
Map("v", "L", "$")

-- Change forward/backward whilst in ins mode
Map("i", "<C-d>", '<Esc>l"_cw', { desc = "Delete one word forward" })
Map("i", "<A-Bs>", '<Esc>l"_cb', { desc = "Delete one word backwward" })

-- Add ispace after cursor whilst in ins mode
Map("i", "<C-i>", "<Space><Esc>i", { desc = "Add on space before cursor" })
Map("i", "<C-h>", "<Left>", { desc = "Move one left" })
Map("i", "<C-l>", "<Right>", { desc = "Move one right" })

-- Give one space down whilst in normal mode
Map("n", "<A-Cr>", "o<Esc>", { desc = "Add one line down" })

-- Center search result
if not util.has("mini.animate") then
	Map("n", "n", "nzz", { nowait = true, desc = "Show + center search results" })
	Map("n", "N", "Nzz", { nowait = true, desc = "Show + center search results" })
end

-- Test selection
Map("n", "<C-g>", "ggVG", { desc = "Select all content [Normal]" })
Map("i", "<C-g>", "<Esc>ggVG<Cr>", { desc = "Select all content" })
Map("v", "<C-g>", "<Esc>", { desc = "Deselect all content" })

-- Clear search with <esc>
Map({ "i", "n" }, "<esc>", "<Cmd>noh<Cr><esc>", { desc = "Clear hlsearch" })

-- Better indenting
Map("v", "<", "<gv", { desc = "Indent Left" })
Map("v", ">", ">gv", { desc = "Indent Right" })

-- Move to window using the <ctrl> hjkl keys
if not util.has("vim-tmux-navigator") then
	Map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
	Map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
	Map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
	Map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
end

-- Move Lines
Map("n", "<A-j>", ":m .+1<Cr>==", { desc = "Move down" })
Map("v", "<A-j>", ":m '>+1<Cr>gv=gv", { desc = "Move down" })
Map("i", "<A-j>", "<Esc>:m .+1<Cr>==gi", { desc = "Move down" })
Map("n", "<A-k>", ":m .-2<Cr>==", { desc = "Move up" })
Map("v", "<A-k>", ":m '<-2<Cr>gv=gv", { desc = "Move up" })
Map("i", "<A-k>", "<Esc>:m .-2<Cr>==gi", { desc = "Move up" })

-- Windows
-- NOTE: Later learn about Tab
Map("n", "<Leader>wd", "<C-W>c", { desc = "Delete window" }) -- same as <Cmd>close
Map("n", "<C-Up>", "<Cmd>resize +2<Cr>", { desc = "Increase window height" })
Map("n", "<C-Down>", "<Cmd>resize -2<Cr>", { desc = "Decrease window height" })
Map("n", "<C-Left>", "<Cmd>vertical resize -2<Cr>", { desc = "Decrease window width" })
Map("n", "<C-Right>", "<Cmd>vertical resize +2<Cr>", { desc = "Increase window width" })

-- Buffers
Map("n", "[b", "<Cmd>bprevious<Cr>", { desc = "Prev buffer" })
Map("n", "]b", "<Cmd>bnext<Cr>", { desc = "Next buffer" })

if not util.has("mini.bufremove") then
	Map("n", "<Leader>bd", "<Cmd>bdelete<Cr>", { desc = "Delete current buffer" })
	Map("n", "<Leader>bD", "<Cmd>bufdo bdelete<Cr>", { desc = "Delete all buffers" })
end

-- Toggle options TODO: define this formatter!
Map("n", "<Leader>uf", function()
  require("usr.lsp.common.formatter").toggle()
end, { desc = "Toggle format on Save" })

Map("n", "<Leader>us", function()
  util.toggle("spell")
end, { desc = "Toggle Spelling" })

Map("n", "<Leader>uw", function()
  util.toggle("wrap")
end, { desc = "Toggle Word Wrap" })

Map("n", "<Leader>ul", function()
  util.toggle("relativenumber", true)
  util.toggle("number")
end, { desc = "Toggle Line Numbers" })

Map("n", "<Leader>ud", function()
  util.toggle_diagnostics()
end, { desc = "Toggle Diagnostics" })

-- Lazygit
Map("n", "<Leader>gg", function()
  util.float_term({ "lazygit" }, { cwd = util.get_root() })
end, { desc = "Lazygit (root dir)" })

Map("n", "<Leader>gG", function()
  util.float_term({ "lazygit" })
end, { desc = "Lazygit (cwd)" })

-- Highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  Map("n", "<Leader>ui", vim.show_pos, {
    desc = "Inspect cursor pos",
  })
end

-- Floating terminal
Map("n", "<Leader>t", function()
  util.float_term(nil, { cwd = util.get_root() })
end, { desc = "Open terminal (root dir)" })

Map("n", "<Leader>T", function()
  util.float_term()
end, { desc = "Open terminal (cwd)" })

-- Quit with prompt
Map({ "n", "v", "x" }, "ZZ", function ()
	util.quit_editor()
end, { desc = "Quit with prompt" })
