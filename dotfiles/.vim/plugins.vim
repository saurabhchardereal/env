" SPDX-License-Identifier: GPL-3.0-or-later
"
" Copyright (C) 2020 Saurabh Charde <saurabhchardereal@gmail.c
"

"==============================================================================
" PLUGINS
"==============================================================================

" Grab latest vim-plug from github
if empty(glob('~/.vim/autoload/plug.vim'))
  silent call system('mkdir -p ~/.vim/autoload')
  silent call system('curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  execute 'source  ~/.vim/autoload/plug.vim'
endif

call plug#begin('~/.vim/plugged')

" Awesome Git wrapper
Plug 'tpope/vim-fugitive'

" Powerful linting tool
Plug 'dense-analysis/ale'

" Text alignment
Plug 'godlygeek/tabular'

" Sexy statusline
Plug 'vim-airline/vim-airline'

" Onedark colorscheme
Plug 'joshdick/onedark.vim'

call plug#end()

"==============================================================================
" PLUGIN CONFIGURATIONS
"==============================================================================

" Sexy colorscheme
if !empty(glob('~/.vim/plugged/onedark.vim'))
colorscheme onedark
endif

" Default list of ALE 'linters' for respective file-type
let g:ale_linters = {
\   'sh': ['shellcheck'],
\   'c': ['clangtidy'],
\   'cpp': ['clangtidy'],
\}

" Default list of ALE 'fixers' for respective file-type
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\   'sh': ['shfmt'],
\}

" Fix file on save
" let g:ale_fix_on_save = 1

" Disable ALE provided LSP features (we are using coc.nvim)
let g:ale_disable_lsp = 1

" shfmt extra options
let g:ale_sh_shfmt_options = '-ci -i 4'

" shellcheck extra options
let g:ale_sh_shellcheck_options = '-s bash -e SC1090'
