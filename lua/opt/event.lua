-- Check if we need to reload the file when it changed
CreateAutoCmd({
  "FocusGained",
  "TermClose",
  "TermLeave",
}, { command = "checktime" })

-- Highlight on yank
CreateAutoCmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 99 })
  end,
})

-- Resize splits if window got resized
CreateAutoCmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Go to last loc when opening a buffer
CreateAutoCmd("BufReadPost", {
  callback = function()
    local mark = Api.nvim_buf_get_mark(0, '"')
    local lcount = Api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(Api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close some filetypes with <q>
CreateAutoCmd("FileType", {
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "startuptime",
    "tsplayground",
    "spectre_panel",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    Map("n", "q", "<Cmd>close<Cr>", {
      buffer = event.buf,
      silent = true,
    })
  end,
})

CreateAutoCmd("FileType", {
  pattern = {
    "gitcommit",
    "markdown",
  },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

CreateAutoCmd("BufReadPre", {
  once = true,
  pattern = "*",
  group = Api.nvim_create_augroup("MySetCursorLine", {}),
  callback = function()
    if Env.theme.transparentbg then
      vim.opt.cursorline = false
    else
      vim.opt.cursorline = true
    end
  end,
})

Log("Events loaded!", "^^ OPT")
