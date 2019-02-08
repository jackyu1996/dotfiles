" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" vim: set foldmethod=marker:
set nocompatible
filetype off

" Plug Settings{{{
call plug#begin('~/.vim/plugged')
Plug 'Chiel92/vim-autoformat'
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
Plug 'luochen1990/rainbow'
Plug 'ledger/vim-ledger', { 'for': 'ledger' }
Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }
Plug 'mattn/emmet-vim'
Plug 'raimondi/delimitmate'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'sirver/ultisnips'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-abolish', { 'on': 'Abolish' }
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
set completeopt=longest,menuone,preview
set conceallevel=1
set encoding=utf-8
set expandtab
set foldenable
set foldmethod=indent
set guioptions="a"
set incsearch
set laststatus=2
set lazyredraw
set nostartofline
set number
set omnifunc=syntaxcomplete#Complete
set pastetoggle=<F12>
set relativenumber
set shiftwidth=4
set showcmd
set showmatch
set showmode
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
            \'python':['autopep8'],
            \'bash': ['shellcheck'],
            \'javascript': ['eslint'],
            \}
let g:ale_sign_error = '×'
let g:ale_sign_warning = '·'
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
let g:lightline = {'colorscheme': 'powerline'}
"}}}
" Limelight {{{
let g:limelight_default_coefficient = 0.7
" }}}
" Rainbow{{{
let g:rainbow_active = 1
"}}}
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
" Vimtex {{{
let g:vimtex_view_method = "zathura"
if empty(v:servername) && exists('*remote_startserver')
    call remote_startserver('VIM')
endif
" }}}
" Xlicp{{{
nnoremap <F8> :call system('xclip -sel clip', @0)<CR>
"}}}
" Youcompleteme{{{
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tag_files = 1
let g:ycm_complete_in_comments = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_min_num_of_chars_for_completion = 100
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_show_diagnostics_ui = 0
let g:ycm_use_ultisnips_completer = 1
"}}}
" Mappings{{{
cnoremap <C-n> <down>
cnoremap <C-p> <up>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>a :Ag<CR>
nnoremap <leader>b :Tagbar<CR>
nnoremap <leader>d :YcmCompleter GoTo<CR>
nnoremap <leader>e :lopen<CR>
nnoremap <leader>f :Autoformat<CR>
nnoremap <leader>g :Goyo<CR>
nnoremap <leader>h :set hlsearch!<CR>
nnoremap <leader>n :Buffers<CR>
nnoremap <leader>p :Files<CR>
nnoremap <leader>x :qa!<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>s :set spell!<CR>
nnoremap <leader>w :w<CR>
"}}}
" Some Autocmd{{{
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \ execute "normal! g'\"" |
            \ endif
autocmd FileType html,css,javascript,vue setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal noexpandtab
autocmd BufNewFile,Bufread *.lgr setfiletype ledger | compiler ledger
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
"}}}
