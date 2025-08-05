vim9script

export def Yank()
	const l0 = line("'[")
	const c0 = col("'[")
	const l1 = line("']")
	const c1_tmp = col("']")

	var delta = 0
    if l0 == l1
		delta = len(v:event.regcontents[-1]) - (c1_tmp - c0)
    endif

    const c1 = c1_tmp + delta
	var match_pattern = $'\%{l0}l\%{c0}c\_.*\%{l1}l\%{c1}c'
	var mid = matchadd('Visual', match_pattern)

	timer_start(300, (_) => {
		if mid > 0
			call matchdelete(mid)
		endif
	})
enddef
