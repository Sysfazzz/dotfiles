" enable syntax highlighting "
syntax on

" enable line numbers "
set number
set relativenumber

" change linenumbers color  "
:highlight LineNr ctermfg=117 guifg=#87ceeb
:highlight CursorLineNr cterm=bold ctermfg=117 guifg=#87ceeb
" enable mouse "
set mouse=a

" highlight cursorline  "
set cursorline
:highlight cursorline cterm=bold ctermbg=236 guibg=#303030

" enable highlighted search pattern  "
set hlsearch

" enable smart search  "
set ignorecase
set smartcase

" indentation configuration  "
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

" enable show matching braces pairs  "
set showmatch

" enable rich color "
if !has('gui_running')
    set t_Co=256
endif
" set termguicolors "

" enable color themes  "
