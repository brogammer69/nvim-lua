local lsp = require('lspconfig')
local U = require('ghost.plugins.lsp.utils')
local icons = require('ghost.theme.icons')

---Common perf related flags for all the LSP servers
local flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 150,
}


---Common capabilities including lsp snippets and autocompletion
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

---Common `on_attach` function for LSP servers
---@param client table
---@param buf integer
local function on_attach(client, buf)
  U.disable_formatting(client)
  U.mappings(buf)

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
end

-- Disable LSP logging
vim.lsp.set_log_level(vim.lsp.log_levels.OFF)


-- set up LSP signs
local signs = {
  Error = icons.error .. ' ',
  Warn = icons.warn .. ' ',
  Hint = icons.hint .. ' ',
  Info = icons.info .. ' ',
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

local function format(diagnostic)
  -- Set the type of diagnostic
  local diagnostic_type = "Error"
  local diagnostic_icon = icons.error

  if diagnostic.severity == vim.diagnostic.severity.WARN then
    diagnostic_icon = icons.warn
    diagnostic_type = "Warning"
  elseif diagnostic.severity == vim.diagnostic.severity.HINT then
    diagnostic_icon = icons.hint
    diagnostic_type = "Hint"
  elseif diagnostic.severity == vim.diagnostic.severity.INFO then
    diagnostic_icon = icons.info
    diagnostic_type = "Info"
  end

  local message = string.format('[%s %s]: %s', diagnostic_icon, diagnostic_type, diagnostic.message)
  return message
end

-- Configuring native diagnostics
-- vim.diagnostic.config({
--     virtual_text = {
--         source = 'always',
--     },
--     float = {
--         source = 'always',
--     },
-- })

---- Show error message on floating window
vim.diagnostic.config({
  underline = true,
  signs = true,
  virtual_text = {
    spacing = 2,
    source = false,
    severity = {
      min = vim.diagnostic.severity.HINT,
    },
    format = format,
  },
  float = {
    show_header = true,
    source = 'if_many',
    border = 'rounded',
    focusable = false,
    format = format,
  },
  update_in_insert = false, -- default to false
  severity_sort = false, -- default to false
})

-- Lua
lsp.sumneko_lua.setup({
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      completion = {
        enable = true,
        showWord = 'Disable',
        -- keywordSnippet = 'Disable',
      },
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = { os.getenv('VIMRUNTIME') },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

-- Rust
lsp.rust_analyzer.setup({
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        allFeatures = true,
        command = 'clippy',
      },
      procMacro = {
        ignored = {
          ['async-trait'] = { 'async_trait' },
          ['napi-derive'] = { 'napi' },
          ['async-recursion'] = { 'async_recursion' },
        },
      },
    },
  },
})

-- Angular
-- 1. install @angular/language-server globally
-- 2. install @angular/language-service inside project as dev dep
lsp.angularls.setup({
  flags = flags,
  capabilities = capabilities,
  on_attach = function(client, buf)
    client.server_capabilities.renameProvider = false
    on_attach(client, buf)
  end,
})

---List of the LSP server that don't need special configuration
local servers = {
  'pyright', --python
  --'zls', -- Zig
  --'gopls', -- Golang
  'tsserver', -- Typescript
  'html', -- HTML
  'cssls', -- CSS
  'jsonls', -- Json
  'yamlls', -- YAML
  'emmet_ls', -- emmet-ls
  -- 'terraformls', -- Terraform
}

local conf = {
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach,
}

for _, server in ipairs(servers) do
  lsp[server].setup(conf)
end

-- NOTE: Using `eslint_d` via `null-ls` bcz it is way fasterrrrrrr.
-- Eslint
--[[ lsp.eslint.setup({
    flags = flags,
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        useESLintClass = true, -- Recommended for eslint >= 7
        run = 'onSave', -- Run `eslint` after save
    },
    -- NOTE: `root_dir` is required to fix the monorepo issue
    root_dir = require('lspconfig.util').find_git_ancestor,
}) ]]
