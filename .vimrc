" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" vim: set foldmethod=marker:
set nocompatible
filetype off

" Plug Settings{{{
call plug#begin('~/.vim/plugged')
Plug '/usr/bin/fzf'
Plug 'airblade/vim-gitgutter'
Plug 'Chiel92/vim-autoformat'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'ledger/vim-ledger', { 'for': 'ledger' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'raimondi/delimitmate'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'sheerun/vim-polyglot'
Plug 'sirver/ultisnips'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch', { 'on': 'Dispatch' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer --go-completer --ts-completer --rust-completer' }
call plug#end()
"}}}
" Basic Settings{{{
filetype plugin indent on
inoremap jk <esc>
let mapleader = " "
let maplocalleader = " "
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set clipboard=unnamedplus
set completeopt=longest,menuone,popup
set completepopup=border:off
set conceallevel=1
set encoding=utf-8
set expandtab
set foldenable
set foldlevelstart=0
set foldmethod=indent
set guioptions="a"
set hidden
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
set termguicolors
set virtualedit=block
set whichwrap=b,s,h,l,<,>,[,]
set wildmenu
set wildmode=list:longest,full
syntax enable
syntax on
colorscheme onedark
"}}}
" Ale{{{
let g:ale_linters = {
            \'bash':       ['shellcheck'],
            \'c':          ['clangtidy'],
            \'cpp':        ['clangtidy'],
            \'go':         ['gobuild'],
            \'javascript': ['eslint'],
            \'python':     ['flake8'],
            \'tex':        ['lacheck'],
            \}
let g:ale_sign_error = '×'
let g:ale_sign_warning = '·'
let g:ale_set_quickfix = 1
let g:ale_set_locllist = 0
"}}}
" Autoformat{{{
let g:formatters_javascript = ['eslint_local']
let g:formatters_python= ['black']
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
" Lightline{{{
let g:lightline = {
            \ 'colorscheme': 'onedark',
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
" Polyglot{{{
" let g:polyglot_disabled = ['latex']
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
let g:tex_flavor = "latex"
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
let g:ycm_min_num_of_chars_for_completion = 2
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
nnoremap <F5> :UndotreeToggle<CR>
nnoremap <F7> :set scrollbind!<CR>
nnoremap <F8> :NERDTreeToggle<CR>
nnoremap <F9> :Dispatch
nnoremap <leader>b :Tagbar<CR>
nnoremap <leader>d :YcmCompleter GoTo<CR>
nnoremap <leader>e :cw<CR>
nnoremap <leader>f :Autoformat<CR>
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
autocmd FileType html,css,javascript,vue,json,xml,markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType markdown,text,tex setlocal linebreak
autocmd FileType yaml,yml setlocal noexpandtab
autocmd BufNewFile,Bufread *.lgr setfiletype ledger
"}}}
