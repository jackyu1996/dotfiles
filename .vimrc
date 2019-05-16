" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" vim: set foldmethod=marker:
set nocompatible
filetype off

" Plug Settings{{{
call plug#begin('~/.vim/plugged')
Plug 'Chiel92/vim-autoformat', { 'on': 'Autoformat' }
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --gocode-completer --tern-completer --clang-completer --rust-completer' }
Plug 'easymotion/vim-easymotion'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
Plug 'junegunn/vim-easy-align'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'ledger/vim-ledger', { 'for': 'ledger' }
Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }
Plug 'mattn/emmet-vim'
Plug 'raimondi/delimitmate'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'sirver/ultisnips'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-abolish', { 'on': 'Abolish' }
Plug 'tpope/vim-dispatch', { 'on': 'Dispatch' }
Plug 'tpope/vim-surround'
Plug 'w0ng/vim-hybrid'
Plug 'w0rp/ale'
call plug#end()
"}}}
" Basic Settings{{{
filetype plugin indent on
inoremap jk <esc>
let mapleader = " "
let maplocalleader = " "
set autochdir
set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set clipboard=unnamedplus
set completeopt=longest,menuone,preview
set conceallevel=1
set encoding=utf-8
set expandtab
set foldenable
set foldmethod=indent
set guioptions="a"
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set nostartofline
set number
set omnifunc=syntaxcomplete#Complete
set pastetoggle=<F12>
set previewheight=2
set relativenumber
set shiftwidth=4
set showcmd
set showmatch
set showmode
set smartcase
set smartindent
set smarttab
set softtabstop=4
set splitright
set tabstop=4
set whichwrap=b,s,h,l,<,>,[,]
set wildmenu
set wildmode=list:longest,full
syntax enable
syntax on
set termguicolors
colorscheme hybrid
"}}}
" Ale{{{
let g:ale_linters = {
            \'bash': ['shellcheck'],
            \'c': ['clangtidy'],
            \'cpp': ['clangtidy'],
            \'javascript': ['eslint'],
            \'python':['flake8'],
            \'tex':['lacheck'],
            \}
let g:ale_sign_error = '×'
let g:ale_sign_warning = '·'
let g:ale_set_quickfix = 1
let g:ale_set_locllist = 0
"}}}
" Autoformat{{{
let g:formatters_javascript = ['eslint_local']
"}}}
" DelimitMate{{{
let delimitMate_balance_matchpairs = 1
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
"}}}
" Easyalign{{{
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
"}}}
" Emmet{{{
let g:user_emmet_expandabbr_key = '<C-e>'
"}}}
" Latex{{{
let g:tex_flavor = "latex"
let g:polyglot_disabled = ["latex"]
"}}}
" Lightline{{{
let g:lightline = {
            \ 'colorscheme': 'powerline',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'filename', 'modified'] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'charvaluehex', 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component': {
            \   'charvaluehex': '0x%B'
            \ },
            \ 'component_function': {
            \ },
            \ }
"}}}
" Limelight {{{
let g:limelight_default_coefficient = 0.7
" }}}
" Netrw {{{
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 10
" }}}
" Tagbar{{{
let g:tagbar_sort = 0
let g:tagbar_type_markdown = {
            \'kinds': [
            \ 'c:H1',
            \ 's:H2',
            \ 'S:H3'
            \]
            \}
"}}}
" Vimtex{{{
let g:vimtex_view_method = "zathura"
let g:vimtex_quickfix_mode = 0
if empty(v:servername) && exists('*remote_startserver')
    call remote_startserver('VIM')
endif
" }}}
" Youcompleteme{{{
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tag_files = 1
let g:ycm_complete_in_comments = 1
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_min_num_of_chars_for_completion = 99
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_show_diagnostics_ui = 0
"}}}
" Mappings{{{
cnoremap <C-n> <down>
cnoremap <C-p> <up>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <F8> :NERDTreeToggle<CR>
nnoremap <F9> :Dispatch<CR>
nnoremap <leader>b :Tagbar<CR>
nnoremap <leader>d :YcmCompleter GoTo<CR>
nnoremap <leader>e :cw<CR>
nnoremap <leader>f :Autoformat<CR>
nnoremap <leader>g :Goyo<CR>
nnoremap <leader>h :set hlsearch!<CR>
nnoremap <leader>n :Buffers<CR>
nnoremap <leader>p :Files<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>s :set spell!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>x :qa!<CR>
"}}}
" Some Autocmd{{{
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \ execute "normal! g'\"" |
            \ endif
autocmd FileType html,css,javascript,vue,json setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType yaml setlocal noexpandtab
autocmd BufNewFile,Bufread *.lgr setfiletype ledger
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
"}}}
