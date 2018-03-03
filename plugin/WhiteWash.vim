" WhiteWash.vim
" Remove trailing whitespace and sequential whitespace between words.

" Maintainer: Michael O'Neill <irish.dot@gmail.com>
" Version:    1.0.1
" GetLatestVimScripts: 3920 1 :AutoInstall: WhiteWash.vim

function! s:white_wash()
	" Save cursor position
	let l:save_cursor = getpos(".")

	" Remove trailing whitespace, quietly.
	call s:remove_trailing_space()

	" Remove sequential whitespace with one of two options.
	if exists("g:WhiteWash_Aggressive") && (g:WhiteWash_Aggressive)
		call s:remove_sequential_space_aggressive()
	else
		call s:remove_sequential_space_friendly()
	endif

	" Restore cursor position
	call setpos('.', l:save_cursor)
endfunction

function! s:remove_trailing_space()
	" Remove trailing whitespace, quietly.
	s/\s\+$//e
endfunction

function! s:remove_sequential_space_aggressive()
	" Remove all sequential whitespace following non-whitespace, quietly.
	s/\S\zs\s\{2,\}/ /eg
endfunction

function! s:remove_sequential_space_friendly()
	" Remove sequential whitespace between words, quietly.
	s/\>\s\{2,\}/ /eg
endfunction

" :Commands
command! -range=% WhiteWash silent <line1>,<line2> call <SID>white_wash()
command! -range=% WhiteWashAggressive silent <line1>,<line2> call <SID>remove_sequential_space_aggressive()
command! -range=% WhiteWashFriendly silent <line1>,<line2> call <SID>remove_sequential_space_friendly()
command! -range=% WhiteWashTrailing silent <line1>,<line2> call <SID>remove_trailing_space()
