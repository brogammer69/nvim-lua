require("nvim-tree").setup({
	open_on_setup = true,
	diagnostics = {
		enable = true,
	},
	view = {
		side = "left",
		width = 20,
	},
	actions = {
		open_file = {
			resize_window = true,
		}
	}
})

-- Keybinding for nvim-tree toggle
vim.keymap.set('n', '<C-n>', '<CMD>NvimTreeToggle<CR>')
