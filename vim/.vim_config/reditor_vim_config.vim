"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Important:
"       This requries that you install https://github.com/amix/vimrc !
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" => Load pathogen paths
""""""""""""""""""""""""""""""
let s:vim_runtime = expand('<sfile>:p:h')."/.."
"echo s:vim_runtime
call pathogen#infect(s:vim_runtime.'/.vim/bundle{}')
call pathogen#infect(s:vim_runtime.'/.vim/after{}')
"call  pathogen#infect(s:vim_runtime. '../{}')
"call  pathogen#infect()
"call pathogen#helptags()


