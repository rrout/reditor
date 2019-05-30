


function! GetMode()
    let mode=mode()
    if mode == 'i'
            "hi ModeColor ctermfg=255 ctermbg=52
        return "INSERT"
    elseif mode == 'V'
            "hi ModeColor ctermfg=255 ctermbg=31
        return "VISUAL"
    elseif mode == 'R'
            "hi ModeColor ctermfg=255 ctermbg=52
        return "REPLACE"
    else
            "hi ModeColor ctermfg=255 ctermbg=22
        return "NORMAL"
    endif
endfunction

function! GetSyntaxItem()
    return "   ".synIDattr(synID(line("."),col("."),1),"name")."   "
endfunction

function! GetFTagName()
    return "  ". GetTagName(line("."))."()  "
endfunction


function! GetFileMode()
            "return " ".getfperm(expand('%:p'))." | ". ( &modified ?"[ + ] ":"  -   " )." | ".(&paste?" PASTE ":"  ---  ")." | ".(&spell?&spelllang:"no spe

    return " ".(&modified==1?" [ + ] ":' [ - ] '). (&paste?"| PASTE ":"|  ---  ")
endfunction

let g:dec_type=" "
function! UpdateDeclaration()
            " Save the last search
    let last_search=@/
            " Save the current cursor position
    let save_cursor = getpos(".")
            " Save the window position
            "normal H
    let save_window = getpos(".")
    call setpos('.', save_cursor)

    let save_cursor = getpos(".")
    try
        let declaration = " "
        if searchdecl(expand("<cword>"), 1, 1) == 0
            let declaration = getline(".")
            let declaration=substitute(declaration, '[\t *()]*\<'.expand("<cword>").'\>.*', '', "Ig")
            let declaration=substitute(declaration, '.*[\t(, ]', '', "Ig")
            "call setpos('.', save_cursor)
            let g:dec_type=declaration
        endif
    catch
    endtry
            " Restore the last_search
    let @/=last_search
            " Restore the window position
    call setpos('.', save_window)
            "normal zt
            " Restore the cursor position
    call setpos('.', save_cursor)

endfunction


function! GetVariableDec()
    return "  ". g:dec_type. " |"
endfunction

function! GetLeftSep()
    return "►" "25ba
endfunction
function! GetRightSep()
    return "◄" "25c4
endfunction

     "［］
    "return "⿴" "25ba
    "return "■" "25ba
    "return "▐" "2590
    "return "│" "25ba
    "return "▌" "25ba
    "return "◆"  "25c6
    "return "❖" "2756
    "return "⠗"
    "return "►" "25ba
    "return "◄" "25c4
    "return "ᐅ"
    "return "▼"  "25bc
    "return "▲" "25b2




hi ModeColor ctermfg=255 ctermbg=22
hi ModeSepColor ctermfg=22 ctermbg=94

hi FileColor ctermfg=255 ctermbg=94
hi FileSepColor ctermfg=94 ctermbg=24

hi FileModeColor ctermfg=255 ctermbg=24
hi FileModeSepColor ctermfg=24 ctermbg=145

hi VariableDecColor ctermfg=255 ctermbg=23
hi SyntaxColor ctermfg=255 ctermbg=145

hi FuncNameSepColor ctermfg=23 ctermbg=145
hi FuncNameColor ctermfg=255 ctermbg=95
hi AttrColor ctermfg=255 ctermbg=23

hi RowColSepColor ctermfg=94 ctermbg=23
hi RowColColor ctermfg=231 ctermbg=94

hi LocSepColor ctermfg=52 ctermbg=94
hi LocColor ctermfg=255 ctermbg=52

"Enable the statusline on demand
if !exists('rutils_statusline_enable')
    let rutils_statusline_enable = 0
endif
if g:rutils_statusline_enable == 0
	finish
endif
set laststatus=2
if has('statusline')
  set statusline=%#ModeColor#                  " set highlighting
  set statusline+=\ %-8{GetMode()}            " set highlighting
  set statusline+=%#ModeSepColor#%{GetLeftSep()}
  set statusline+=%#FileColor#                 " set highlighting
  set statusline+=\ %-f\                          " file name
  set statusline+=%#FileSepColor#%{GetLeftSep()}
  set statusline+=%#FileModeColor#              " syntax highlight group under cursor
  set statusline+=%{GetFileMode()}                " file format
  set statusline+=%#FileModeSepColor#%{GetLeftSep()}
  set statusline+=%#SyntaxColor#              " syntax highlight group under cursor
  set statusline+=%=                           " ident to the right
  set statusline+=%#FuncNameSepColor#%{GetRightSep()}
  set statusline+=%#VariableDecColor#              " syntax highlight group under cursor
  set statusline+=%10.40{GetVariableDec()}                " file format
            "set statusline+=%#FuncNameColor#              " syntax highlight group under cursor
  set statusline+=%10.50{GetFTagName()}              " syntax highlight group under cursor
            "set statusline+=%#AttrColor#              " syntax highlight group under cursor
            "set statusline+=%-20{GetSyntaxItem()}              " syntax highlight group under cursor
  set statusline+=%#RowColSepColor#%{GetRightSep()}
  set statusline+=%#RowColColor#\ %5l\ \:\ %-3v\          " cursor position/offset
  set statusline+=%#LocSepColor#%{GetRightSep()}
  set statusline+=%#LocColor#\ %(\ %L\ \/\ %-3p%%\ %)\               " file format
            "set statusline+=%#LocColor#\ %-6P\         " cursor position/offset
endif

