require("nvim-tree").setup({
  open_on_setup = true,
	diagnostics = {
		enable = true,
	},
	view = {
		side = "left",
		width = 30,
	},
	actions = {
		open_file = {
			resize_window = true,
		}
	}
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    --open the tree
    require("nvim-tree.api").tree.open()
  end
})


-- Keybinding for nvim-tree toggle
vim.keymap.set('n', '<C-n>', '<CMD>NvimTreeToggle<CR>')
