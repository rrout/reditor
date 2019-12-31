"----------------------------------------
"             CTAGS/CSCOPE SEARCH 
"----------------------------------------
let s:result=[]
function! UpdateBuf( file, no, pattern, search)
	
	let tag = GetStackTopTag()
    if tag.TagType == "TAG" 
		let data = a:search
	else
		"let data = a:file. "\t".a:no."\t". a:search
		let data = substitute(a:search, '^[ \t]*', '', "g")
		let data = printf("%-30s  |%4d|  %s", a:file, a:no, data)
	endif
	call add(s:result, data)
endfunc

function! s:SearchCmd(search_type, pattern)
	let s:result=[]
	"let tag = GetStackTopTag()
	let l:line_no = getpos(".")

   
    echo a:search_type a:pattern." call UpdateBuf( bufname(\"%\") ,  line(\".\") ,  \"".a:pattern."\", getline(\".\") )"
	execute  a:search_type." ".a:pattern." call UpdateBuf( bufname(\"%\") ,  line(\".\") ,  \"".a:pattern."\", getline(\".\") )"
    call setpos(".", l:line_no)

	if len(s:result)>0
		"call CopyCurrentToStackTop()
		"call PushTag(a:pattern, a:pattern, bufname("%"))
		call SetStackTopTag("SEARCH", "SEARCH", bufname("%"), "FILE", l:line_no)
		call OpenTag("SEARCH", a:pattern, s:result)
	endif
endfunc



function! GtagsAutoComplete_ctags()
    call inputsave()
        let l:input = input('Enter pattern:')
            call inputrestore()
	"let l:input = input("CS-DEF-PATTERN:","", "custom,GtagsComplete_subsearch")
	if(l:input == '') 
		return 
	endif

	let l:pattern = l:input

	let l:pattern = substitute(l:pattern, '^.', '', "g")

	let search_type = l:input[0]

	if search_type == '~'
		call s:SearchCmd("cscope find s", l:pattern)
	else
		call s:SearchCmd("cscope find s", l:input)
	endif

endfunc
"exec " noremap	" . g:gtags_cmd_ctags_def_search . " :call GtagsAutoComplete_ctags() <CR>"
"exec " inoremap " . g:gtags_cmd_ctags_def_search . " <ESC> :call GtagsAutoComplete_ctags() <CR>"

