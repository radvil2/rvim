-- @desc: auto completion brigde
local M = {}

M.id = "hrsh7th/nvim-cmp"

local has_words_before = function()
  local line, col = unpack(Api.nvim_win_get_cursor(0))
  return col ~= 0 and Api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local preview_formatter = function(entry, item)
  local icons = require("media.icons").KindIcons
  local sources = {
    nvim_lsp = item.kind,
    luasnip = " SNIP",
    buffer = " BUFF",
    path = " PATH",
  }
  if icons[item.kind] then
    item.kind = icons[item.kind] .. item.kind
  end
  if sources[entry.source.name] then
    item.menu = sources[entry.source.name]
  end
  return item
end

M.dependencies = {
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
}

M.opts = function()
  local luasnip = require("luasnip")
  local nvim_cmp = require("cmp")
  local cmap = nvim_cmp.mapping
  return {
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    preselect = nvim_cmp.PreselectMode.Item,
    window = {
      completion = nvim_cmp.config.window.bordered(),
      documentation = nvim_cmp.config.window.bordered(),
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = cmap.preset.insert({
      -- Accept currently selected item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmap.confirm({ select = true }),
      ["<C-Space>"] = cmap.complete({}),
      ["<C-u>"] = cmap.scroll_docs(-4),
      ["<C-d>"] = cmap.scroll_docs(4),
      ["<C-e>"] = cmap.abort(),
      ["<C-x>"] = cmap.close(),
      ["<C-n>"] = cmap(function(fallback)
        if nvim_cmp.visible() then
          nvim_cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          nvim_cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-p>"] = cmap(function(fallback)
        if nvim_cmp.visible() then
          nvim_cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    sources = nvim_cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    }),
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = preview_formatter,
    },
  }
end

M.repo = {
  M.id,
  dependencies = M.dependencies,
  event = "InsertEnter",
  opts = M.opts,
}

return M
