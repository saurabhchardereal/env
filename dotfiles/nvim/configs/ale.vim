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

" Enable below option to only trigger linters from `g:ale_linters` list
" NOTE: ALE will enable as many linters as possible by default
" let g:ale_linters_explicit = 1

" Use better error/warning signs
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
highlight ALEWarningSign guifg=#FFFF00

" Mapping to quickly fix
nnoremap <silent> <Leader>f :ALEFix<CR>

" Disable ALE provided LSP features (we are using coc.nvim)
let g:ale_disable_lsp = 1

" shfmt extra options
" `-ci`  -- format case statements
" `-i 4` -- indents will have width of 4 spaces
let g:ale_sh_shfmt_options = '-ci -i 4'

" shellcheck extra options
" SC1090 -- Can't follow non-constant source. Use a directive to specify location
" SC1091 -- Almost the same reason as above
let g:ale_sh_shellcheck_options = '-s bash -e SC1090,SC1091'

" Set `-style=Google`
let g:ale_c_clangformat_style_option = 'Google'

" Enable below option to use local .clang-format file
" let g:ale_c_clangformat_use_local_file = 1