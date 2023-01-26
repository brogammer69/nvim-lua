require("gruvbox").setup({
  bold = false,
  italic = false,
  undercurl = true,
  underline = false
})

--set the theme
local ok, _ = pcall(vim.cmd, 'colorscheme gruvbox')
if not ok then
  vim.cmd 'colorscheme default' -- if the above fails, then use default
end
