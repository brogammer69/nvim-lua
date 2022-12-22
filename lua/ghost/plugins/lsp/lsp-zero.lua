local lsp = require('lsp-zero')
local cmp = require("cmp")
local luasnip = require('luasnip')

lsp.preset('recommended')

-- First disable the default key bindings
lsp.set_preferences({
  sign_icons = {
    error = '',
    warn = '',
    hint = '',
    info = ''
  }
})

-- Overriding the default on_attach function of lsp-zero
lsp.on_attach(function (_, buf) -- client should be in place of _

  --for diagnostics to show on hover
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'line',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })

  -- Creating LSP mappings
  local opts = { buffer = buf, remap = false }
  local map = vim.keymap.set

  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map('i', '<C-space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map('n', '<leader>c', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  map('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  map('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  map('n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
end)

-- Setting up custom mappings for nvim-cmp
-- First a local function to check if a line has words before cursor
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

lsp.setup_nvim_cmp({
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<up>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<down>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  completion = {completeopt = 'menu,menuone,noselect'},
})

lsp.nvim_workspace()

lsp.setup()
