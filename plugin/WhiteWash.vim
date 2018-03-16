" WhiteWash.vim
" Remove trailing whitespace and sequential whitespace between words.

" Maintainer: Michael O'Neill <irish.dot@gmail.com>
" Version:    2.0.0
" GetLatestVimScripts: 3920 1 :AutoInstall: WhiteWash.vim

" Set default options
let g:WhiteWash = {
	\ 'auto': {
		\ 'commas': 1,
		\ 'sequential': 1,
		\ 'trailing': 1,
	\ },
	\ 'aggressive': {
		\ 'commas': 0,
		\ 'sequential': 0,
	\ },
\ }

function! s:white_wash(aggressive)
	" Save cursor position
	let l:save_cursor = getpos('.')

	if g:WhiteWash.auto.trailing
		" Remove trailing whitespace if enabled
		call s:remove_trailing_space()
	endif

	if g:WhiteWash.auto.sequential
		" Remove sequential whitespace if enabled
		call s:remove_sequential_space(g:WhiteWash.aggressive.sequential || a:aggressive)
	endif

	if g:WhiteWash.auto.commas
		" Add space after commas if enabled
		call s:add_space_after_commas(g:WhiteWash.aggressive.commas || a:aggressive)
	endif

	" Restore cursor position
	call setpos('.', l:save_cursor)
endfunction

function! s:remove_trailing_space()
	" Remove trailing whitespace, quietly.
	s/\s\+$//e
endfunction

function! s:remove_sequential_space(aggressive)
	if a:aggressive == 0
		" Remove sequential whitespace between words, quietly.
		s/\>\s\{2,\}/ /eg
	else
		" Remove all sequential whitespace following non-whitespace, quietly.
		s/\S\zs\s\{2,\}/ /eg
	endif
endfunction

function! s:add_space_after_commas(aggressive)
	if a:aggressive == 0
		" Add a space after commas which do not appear to be part of a large
		" number (e.g. 1,234,567,890), quietly.
		s/\S,\zs\ze\(\(\d\d\d\(\D\|$\)\)\|\\\)\@!\S/ /eg
	else
		" Add a space after all cramped commas, quietly.
		s/\S,\zs\ze\S/ /eg
	endif
endfunction

" :Commands
command! -range=% WhiteWash <line1>,<line2> call <SID>white_wash(v:null)
command! -range=% WhiteWashAggressive <line1>,<line2> call <SID>white_wash(1)
command! -range=% WhiteWashCommas <line1>,<line2> call <SID>add_space_after_commas(g:WhiteWash.aggressive.commas)
command! -range=% WhiteWashSequential <line1>,<line2> call <SID>remove_sequential_space(g:WhiteWash.aggressive.sequential)
command! -range=% WhiteWashTrailing <line1>,<line2> call <SID>remove_trailing_space()
