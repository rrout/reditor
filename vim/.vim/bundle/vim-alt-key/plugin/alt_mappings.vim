if exists("g:loaded_alt_mappings") || v:version < 700 || &cp
  finish
endif
if !exists("g:dont_need_alt_mappings")
    let g:dont_need_alt_mappings = 0
endif

if g:dont_need_alt_mappings == 1
    finish
endif
let g:loaded_alt_mappings = 1

set ttimeout
if &ttimeoutlen == -1
  set ttimeoutlen=50
endif

function! s:printable_characters()
  " leaving out problematic characters: 'O', double quote, pipe and '['
  "let ascii_nums = [33] + range(35, 61) + range(63, 78) + range(80, 90) + range(92, 123) + [125, 126]

  "Mapp only keys [d, g, q, s, t] : refer Asscii table @
  "https://theasciicode.com.ar/ascii-printable-characters/capital-letter-t-uppercase-ascii-code-84.html
  let ascii_nums = [100, 103, 113, 115, 116]
  return map(ascii_nums, 'nr2char(v:val)')
endfunction

function! s:enable_alt_map(char)
  exe "set <M-".a:char.">=\<Esc>".a:char
endfunction

function! s:enable_alt_map_for_special_chars()
  " double quote
  "exe 'set <M-\">=\"'
  " pipe
  "exe 'set <M-bar>=\|'
  " space - messes all other mappings
  " exe "set <M-space>= "
  " Can't get this one to work
  " exe "set <M-\>>=\>"
  " left bracket just messes vim up
  " exe 'set <M-[>=['
endfunction

if !has("gui_running")
  for char in s:printable_characters()
    call s:enable_alt_map(char)
  endfor
  call s:enable_alt_map_for_special_chars()
endif
