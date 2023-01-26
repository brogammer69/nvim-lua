--keybinds

local map = vim.keymap.set
local opts = { silent = true, remap = false }

--keybinding for toggleterm
map('n', [[<c-\>]], '<cmd>:ToggleTerm<CR>', opts)

