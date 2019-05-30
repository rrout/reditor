" NOTE: You must, of course, install kg / the_silver_searcher
"command! -bang -nargs=* -complete=file Ksearch call kg#GtagsKg('kg<bang>',<q-args>)


"command! -bang -nargs=* -complete=file AgBuffer call ag#AgBuffer('grep<bang>',<q-args>)
"command! -bang -nargs=* -complete=file AgAdd call ag#Ag('grepadd<bang>', <q-args>)
"command! -bang -nargs=* -complete=file AgFromSearch call ag#AgFromSearch('grep<bang>', <q-args>)
"command! -bang -nargs=* -complete=file LAg call ag#Ag('lgrep<bang>', <q-args>)
"command! -bang -nargs=* -complete=file LAgBuffer call ag#AgBuffer('lgrep<bang>',<q-args>)
"command! -bang -nargs=* -complete=file LAgAdd call ag#Ag('lgrepadd<bang>', <q-args>)
"command! -bang -nargs=* -complete=file AgFile call ag#Ag('grep<bang> -g', <q-args>)
"command! -bang -nargs=* -complete=help AgHelp call ag#AgHelp('grep<bang>',<q-args>)
"command! -bang -nargs=* -complete=help LAgHelp call ag#AgHelp('lgrep<bang>',<q-args>)

function! GtagsKSearch()
	let l:input = input("KSEARCH-PATTERN:", "")
	if(l:input == '') 
		return 
	endif
	"echoerr "[".l:input. "]"
	call kg#GtagsKg( 'kg', l:input)
endfunction

if !exists('gtags_cmd_open_kg_search')
    let gtags_cmd_open_kg_search = '<leader><C-F><C-F>'
endif

"exec "noremap  ". g:gtags_cmd_open_kg_search ."  :Ksearch  \"\"<left>"
"exec "inoremap ". g:gtags_cmd_open_kg_search ."  <ESC> :Ksearch \"\"<left>"

 " :call GtagsAutoComplete_subg() <CR>"
exec "noremap  ". g:gtags_cmd_open_kg_search ." :call GtagsKSearch() <CR>"
exec "inoremap ". g:gtags_cmd_open_kg_search ." <ESC>:call GtagsKSearch() <CR>"


