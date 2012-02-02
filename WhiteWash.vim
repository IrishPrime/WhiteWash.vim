" WhiteWash.vim
" Strip characters from the wrong encoding.
" Remove trailing white space.
" Remove sequential white space between words.

" Maintainer: Michael O'Neill <irish.dot@gmail.com>
" Version:    2011.11.03
" GetLatestVimScripts:

function! s:WhiteWash()
	" Save cursor position
	let l:save_cursor = getpos(".")
	" Strip trailing ^Ms, quietly.
	%s/$//e
	" Remove trailing white space, quietly.
	%s/\s\+$//e

	" Remove sequential white space with one of two options.
	if exists("g:WhiteWash_Aggressive") && (g:WhiteWash_Aggressive)
		call s:WhiteWashAggressive()
	else
		call s:WhiteWashLazy()
	endif

	" Restore cursor position
	call setpos('.', l:save_cursor)
endfunction

function! s:WhiteWashLazy()
	" Remove sequential white space between words, quietly.
	%s/\>\s\{2,\}/ /eg
endfunction

function! s:WhiteWashAggressive()
	" Remove all sequential white space following non-whitespace, quietly.
	%s/\(\S\)\s\{2,\}/\1 /eg
endfunction

" :Commands
command! -range=% WhiteWash :silent call <SID>WhiteWash()
command! -range=% WhiteWashAggressive :silent call <SID>WhiteWashAggressive()
command! -range=% WhiteWashLazy :silent call <SID>WhiteWashLazy()
