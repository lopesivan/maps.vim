" $Id$
" Name Of File: |;n|
"
"  Description: Vim plugin
"
"       Author: Ivan Carlos S. Lopes <lopesivan (at) poli (dot) com (dot) br>
"   Maintainer: Ivan Carlos S. Lopes <lopesivan (at) poli (dot) com (dot) br>
"
"  Last Change: $Date:$
"      Version: $Revision:$
"
"    Copyright: This script is released under the Vim License.
"

if &cp || exists("g:loaded_hide")
	finish
endif

let g:loaded_hide = "v01"
let s:keepcpo     = &cpo
set cpo&vim

" ----------------------------------------------------------------------------

if exists("s:hidden")
	finish
else
	let s:hidden = {}
endif

function s:Hide( hlgroup )
	let hl = s:GetArgument(a:hlgroup)
	if has_key(s:hidden,hl)
		return 0
	endif
	let realgroup = synIDattr(synIDtrans(hlID(hl)),'name')
	if empty(realgroup)
		return 0
	endif
	let s:hidden[hl]=realgroup
	exec ":hi! link ".hl." Ignore"
	return 1
endfunction

function s:Unhide( hlgroup, ...)
	if a:0 && a:1 && empty(a:hlgroup)
		return s:UnhideAll()
	endif
	let hl = s:GetArgument(a:hlgroup)
	if !has_key(s:hidden,hl)
		return 0
	endif
	exec ":hi! link ".hl." ".s:hidden[hl]
	call remove(s:hidden,hl)
	return 1
endfunction

function s:UnhideAll()
	let ret=0
	for e in keys(s:hidden)
		call s:Unhide(e)
		let ret=1
	endfor
	return ret
endfunction

function s:HideToggle( hlgroup )
	let hl = s:GetArgument(a:hlgroup)
	if has_key(s:hidden,hl)
		call s:Unhide(hl)
	else
		call s:Hide(hl)
	endif
endfunction

function s:GetArgument( arg )
	if empty(a:arg)
		return synIDattr(synID(line("."), col("."), 1), "name")
	endif
	return a:arg
endfunction

function s:GetHLGroups()
	let hl = ""
	redir => hl
	silent :hi
	redir END
	let hlgroups = []
	for h in split(hl,"\n")
		if h =~ '^\w'
			call add(hlgroups,matchstr(h,'^\w*'))
		endif
	endfor
	return hlgroups
endfunction

function s:HideComplete(a,cmdline,c)
	let complete = ""
	let cursorHL = s:GetArgument("")
	if !empty(cursorHL) && ( !has_key(s:hidden,cursorHL) || a:cmdline !~ 'Hide\>' )
		let complete.=cursorHL."\n"
	endif
	if !empty(s:hidden) && a:cmdline !~ 'Hide\>'
		let complete = join(keys(s:hidden),"\n")."\n"
	endif
	let complete.=join(sort(s:GetHLGroups(),"s:CompareHLGroups"),"\n")
	return complete
endfunction
function s:CompareHLGroups( k1, k2)
	return a:k1 =~ '^'.&ft ? -1 : a:k2 =~ '^'.&ft ? 1 : a:k1 < a:k2 ? -1 : a:k1 > a:k2
endfunction

function s:Hidden()
	if empty(s:hidden)
		echo "Nothing is hidden."
		return
	endif
	let temp = copy(s:hidden)
	try
		call s:UnhideAll()
		for h in keys(temp)
			exec "echohl ".temp[h]
			echo h."\t->\t".temp[h]
		endfor
	finally
		echohl None
		for h in keys(temp)
			call s:Hide(h)
		endfor
	endtry
endfunction

"Hide higroup at cursor or <arg1>
com  -bar -nargs=? -complete=custom,s:HideComplete Hide :call s:Hide(<q-args>)
"Unhide <arg1> or everything hidden, if bang is given
com  -bar -bang -nargs=? -complete=custom,s:HideComplete Unhide :call s:Unhide(<q-args>,<bang>0)
"Toggle hidden/visible, behaviour like Hide
com  -bar -nargs=? -complete=custom,s:HideComplete HideToggle :call s:HideToggle(<q-args>)
"List hidden
com  -bar Hidden :call s:Hidden()

" ----------------------------------------------------------------------------

let &cpo= s:keepcpo
unlet s:keepcpo

" vim: ts=8
