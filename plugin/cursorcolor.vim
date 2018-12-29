if !cursorcolor#DetectTerm()
	finish
endif

call cursorcolor#Init()

augroup CursorColor
	autocmd!
	autocmd VimLeave * call cursorcolor#Reset()
augroup end
