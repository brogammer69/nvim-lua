
"config section
syntax on
set number
set noshowmode "the mode below lightline disappears, ie the default is disabled
set nowrap "lines are not wraped if longer than the window
set expandtab "convert tab to spaces :(
set tabstop=2 "number of spaces for a tab
set shiftwidth=2 "how many spaces for each level of indentation
set softtabstop=2 "don't know that this does
set autoindent "preserve indentation
set smartindent "smart indentation for language
set incsearch "incremental search
set hlsearch "highlight search patterns
set nohlsearch "remove highlighting after searching
set ignorecase "case insensitive search
filetype plugin indent on "enable syntax highlighting
set noswapfile "vim generally makes a swap file of the opened file. So noswapfile
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o "no repetation of comment to new line
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8


"using vim-plugg
call plug#begin("~/.vim/plugged")
  " Plugin Section
 	Plug 'itchyny/lightline.vim'
 	Plug 'ap/vim-css-color'
	Plug 'Yggdroot/indentLine'
 	Plug 'scrooloose/nerdtree'
  "Plug 'morhetz/gruvbox'
  Plug 'joshdick/onedark.vim'
  Plug 'chriskempson/base16-vim'
	Plug 'itchyny/vim-gitbranch'
	"Plug 'nvim-treesitter/nvim-treesitter' "for syntax highlighting for appropriate language. And apparently it only works in neovim 0.7+
	"Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'ryanoasis/vim-devicons'
call plug#end()

"Config Section
set background=dark

"Config section for gruvbox
"let g:gruvbox_italic=1 "makes comment italic
"let g:onedark_terminal_italics=1

colorscheme onedark "base16-gruvbox-dark-hard
"highlight Normal guibg=NONE
"below line preserves transparency
"highlight Normal ctermbg=NONE

" config for file manager
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-t> :NERDTreeToggle<CR>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

"automatically open NERDTree if a directory is opened with vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd w | endif

"config for auto closing parenthesis and quotes
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {  }<left><left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"

"config section to disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

"remap esacpe key to jj in insert mode
inoremap jj <esc>

"config section for lightline
set laststatus=2 "lightline appears
set ttimeoutlen=30
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }


" open terminal below 
"nnoremap <leader>t: below terminal<CR>
nnoremap <leader>t :below 10sp term://$SHELL<cr> "this is for neovim. Creates a 10 row terminal below the current buffer

" Config section for fzf
" Fzf
nnoremap <leader><leader> :GFiles<CR>
nnoremap <leader>fi       :Files<CR>
nnoremap <leader>C        :Colors<CR>
nnoremap <leader><CR>     :Buffers<CR>
nnoremap <leader>fl       :Lines<CR>
nnoremap <leader>ag       :Ag! <C-R><C-W><CR>
nnoremap <leader>m        :History<CR>

" Config for indentLine
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
