-- This is the file from where we will install our plugins


local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' --this is the plugin manager

  use('nvim-lua/plenary.nvim')

  -- My plugins here

  use({
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
    end,
  })

  use({
    'nvim-lualine/lualine.nvim',
    event = 'BufEnter',
    config = function()
      require('ghost.plugins.lualine')
    end,
  })

  use({
    'ellisonleao/gruvbox.nvim',
    event = 'BufEnter',
    config = function()
      require('ghost.plugins.gruvbox')
    end
  })

  use ({
    'numToStr/FTerm.nvim',
    config = function()
      require('ghost.plugins.FTerm')
    end
  })

  use({
    'nvim-tree/nvim-tree.lua',
    event = 'VimEnter',
    config = function()
      require('ghost.plugins.nvim-tree')
    end,
  })

  use {
   'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  use({
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
    config = function()
      require('ghost.plugins.indentline')
    end,
  })

  use({
    'norcalli/nvim-colorizer.lua',
    event = 'BufRead',
    config = function()
      require('colorizer').setup()
    end,
  })

  use({
    {
      'nvim-treesitter/nvim-treesitter',
      event = 'CursorHold',
      run = ':TSUpdate',
      config = function()
        require('ghost.plugins.treesitter')
      end,
    },
    --{ 'nvim-treesitter/playground', after = 'nvim-treesitter' },
    { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
    { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' },
    { 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' },
    { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' },
  })

  use({
    {
      'nvim-telescope/telescope.nvim',
      event = 'CursorHold',
      config = function()
        require('ghost.plugins.telescope')
      end,
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      after = 'telescope.nvim',
      run = 'make',
      config = function()
        require('telescope').load_extension('fzf')
      end,
    },
    {
      'nvim-telescope/telescope-symbols.nvim',
      after = 'telescope.nvim',
    },
  })

  use({
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  })

  --Lsp config
--[[   use({
    'neovim/nvim-lspconfig',
    event = 'BufRead',
    config = function()
      require('ghost.plugins.lsp.servers')
    end,
    requires = {
      {
        -- WARN: Unfortunately we won't be able to lazy load this
        'hrsh7th/cmp-nvim-lsp',
      },
    },
  })

  use({
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufRead',
    config = function()
        require('ghost.plugins.lsp.null-ls')
    end,
  })

  use({
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      config = function()
        require('ghost.plugins.lsp.nvim-cmp')
      end,
      requires = {
        {
          'L3MON4D3/LuaSnip',
          event = 'InsertEnter',
          config = function()
            require('ghost.plugins.lsp.luasnip')
          end,
          requires = {
            {
              'rafamadriz/friendly-snippets',
              event = 'CursorHold',
            },
          },
        },
      },
    },
    { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
  })
 ]]

  use ({
    'VonHeikemen/lsp-zero.nvim',
    config = function() require('ghost.plugins.lsp.lsp-zero') end,
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  })

  -- NOTE: nvim-autopairs needs to be loaded after nvim-cmp, so that <CR> would work properly
  use({
    'windwp/nvim-autopairs',
    event = 'InsertCharPre',
    after = 'nvim-cmp',
    config = function()
      require('ghost.plugins.pairs')
    end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
