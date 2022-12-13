vim.g.bufferline = {
	animation = true,
	tabpages = true,
	clickable = true,
	icon_close_tab = "",
	icon_separator_active = "",
	icon_separator_inactive = ""
}

-- Always close the buffer when window is closed ie :q is used
vim.api.nvim_create_autocmd('WinClosed', {
  callback = function(tbl)
    vim.api.nvim_command('BufferClose ' .. tbl.buf)
  end,
  group = vim.api.nvim_create_augroup('barbar_close_buf', {})
})
