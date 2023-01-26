--[[
  Three types of configurations options
    vim.bo -> local to buffer
    vim.o -> for global configurations
    vim.wo -> local to the window

]]

--General Configuartions

local o = vim.o
local g = vim.g

-- line numbers
o.number = true
o.relativenumber = true

-- line wraping
o.wrap = false

-- tabs and indentation
o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.autoindent = true
o.smartindent = true

-- searching
o.incsearch = true
o.hlsearch = false
o.ignorecase = true

-- Undo and backup options
o.backup = false
o.writebackup = false
o.swapfile = false
o.undofile = false

-- Gutter
o.signcolumn = "yes"

--hidden
o.hidden = false

-- show mode
o.showmode = false

-- encoding
o.encoding = "utf-8"

-- terminal colors
o.termguicolors = true
g.background = 'dark'

-- Decrease update time
o.timeoutlen = 500
o.updatetime = 200

o.list = true
o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'
-- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- o.formatoptions = 'qrn1'

-- Makes neovim and host OS clipboard play nicely with each other
-- o.clipboard = 'unnamedplus'

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Preserve view while jumping
o.jumpoptions = 'view'

-- Map <leader> to space
g.mapleader = ' '
g.maplocalleader = ' '



