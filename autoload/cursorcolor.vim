function! cursorcolor#Init() abort
	if !exists("g:cursor_color")
		return
	endif
	let termcaps = map(
		\copy(g:cursor_color),
		\{mode, color -> cursorcolor#CtlSeq(color)}
	\)
	let &t_SI = termcaps["insert"]
	let &t_SR = termcaps["replace"]
	let &t_EI = termcaps["normal"]
	" Set normal mode cursor color on startup. This is necessary because
	" t_EI isn't emitted at startup (it is only sent when leaving other
	" modes).
	execute "silent !printf" shellescape(termcaps["normal"])
endfunction

function! cursorcolor#CtlSeq(color) abort
	return "\<Esc>]12;" . a:color . "\x7"
endfunction

function! cursorcolor#Reset() abort
	" Reset cursor color on exit. This is necessary because:
	" > When Vim exits the shape for Normal mode will remain. The shape
	" > from before Vim started will not be restored.
	" (from :help termcap-cursor-shape).
	execute "silent !printf \<Esc>]112\x7"
endfunction

function! cursorcolor#DetectTerm() abort
	if &term =~? "xterm"
		return v:true
	endif
	if $TMUX_PANE !=# ""
		return v:true
	endif
	return v:false
endfunction
