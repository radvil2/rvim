local base = {
  backupdir = Env.path.cache .. "/backup/",
  backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
  diffopt = "internal,filler,closeoff,algorithm:patience,iwhiteall",
  directory = Env.path.cache .. "/swag/",
  shada = "!,'300,<50,@100,s10,h",
  spellfile = Env.path.cache .. "/spell/en.uft-8.add",
  encoding = "utf-8",
  fileencoding = "utf-8",
  undodir = Env.path.cache .. "/undo/",
  viewdir = Env.path.cache .. "/view/",
  wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
}

local global = {
    markdown_syntax_conceal = false,
    mkdp_auto_start = false,
    one_allow_italics = true,
    override_nvim_web_devicons = false,
    table_mode_corner = "|",
    vim_json_syntax_conceal = false,
}

local blacklisted = {
    "2html_plugin",
    "bugreport",
    "compiler",
    "fzf",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "matchit",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "optwin",
    "rplugin",
    "rrhelper",
    "spellfile_plugin",
    "synmenu",
    "tar",
    "tarPlugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

local providers = {
    "perl",
    "ruby",
}

for opt, value in pairs(base) do
  vim.opt[opt] = value
end

for opt, value in pairs(global) do
    vim.g[opt] = value
end

for _, plugin in ipairs(blacklisted) do
    vim.g["loaded_" .. plugin] = 1
end

for _, provider in ipairs(providers) do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- don't show redundant messages from ins-completion-menu
vim.opt.shortmess:append("c")

-- disable nvim intro
vim.opt.shortmess:append("sI")

-- undercurl
vim.cmd('let &t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"')
vim.cmd('let &t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"')

-- reset key
Map({ "n", "x", "v" }, "q", "<Nop>")
Map({ "n", "x", "v" }, "Q", "<Nop>")
Map({ "n", "x", "v" }, "<NL>", "<Nop>")
Map({ "n", "x", "v" }, "<C-w>", "<Nop>")
Map({ "n", "x", "v" }, "<C-F>", "<Nop>")
Map({ "n", "x", "v" }, "<C-B>", "<Nop>")
Map("n", "<A-Cr>", "<Nop>")
Map("i", "<A-Bs>", "<Nop>")
Map("i", "<C-D>", "<Nop>")

-- set user's map leader key
if Env and Env.g.mapleader ~= nil then
    Map({ "n", "x", "v" }, Env.g.mapleader, "<Nop>")
    vim.g.mapleader = Env.g.mapleader
    vim.g.maplocalleader = Env.g.maplocalleader
else
    Map({ "n", "x", "v" }, " ", "<Nop>")
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "
end

Log("Override default!", "^ ROOT")
