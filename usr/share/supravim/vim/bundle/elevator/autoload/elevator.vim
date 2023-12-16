vim9script noclear

# defaults:
if !exists('g:elevator#timeout_msec')
  g:elevator#timeout_msec = 2000
endif
if !exists('g:elevator#width')
  g:elevator#width = 1
endif

var s_state = {
  scrolloff: -1,
  screenrow: -1,
  topline: -1,
  dragging: false,
  scrolled_winid: -1,
  popup_id: -1,
  timer_id: -1,
}

def S__clamp(value__a: number, min__a: number, max__a: number): number
  if value__a < min__a
    return min__a
  elseif value__a > max__a
    return max__a
  else
    return value__a
  endif
enddef

def S__calculate_scale(winid__a: number): float
  var winheight = winheight(winid__a)
  return 1.0 * winheight / (line('$', winid__a) + winheight)
enddef

export def Show(winid__a: number)
  if s_state.dragging
    return
  endif

  S__stop_timer()

  if winid__a == 0 # over command line
    var mousepos = getmousepos()
    # find window above mouse cursor:
    for wininfo in getwininfo()
      if (
        wininfo.winrow + wininfo.height + &cmdheight == &lines &&
        wininfo.wincol < mousepos.screencol && wininfo.wincol + wininfo.width > mousepos.screencol
      )
        s_state.scrolled_winid = wininfo.winid
        break
      endif
    endfor
  else
    s_state.scrolled_winid = winid__a
  endif

  if s_state.popup_id == -1
    s_state.popup_id = popup_create('', {
      pos: 'topleft',
      minwidth: g:elevator#width,
      dragall: true,
      zindex: 1,
    })
  endif

  S__set_geometry()
  S__restart_timer()
enddef

def S__stop_timer()
  if s_state.timer_id != -1
    timer_stop(s_state.timer_id)
    s_state.timer_id = -1
  endif
enddef

def S__restart_timer()
  S__stop_timer()
  s_state.timer_id = timer_start(g:elevator#timeout_msec, (_) => S__close())
enddef

def S__close()
  popup_close(s_state.popup_id)
  s_state.popup_id = -1
  s_state.timer_id = -1
enddef

export def S__set_geometry()
  var wininfo = getwininfo(s_state.scrolled_winid)[0]
  var scale = S__calculate_scale(s_state.scrolled_winid)
  if scale >= 1.0
    S__close()
    return
  endif

  var popup_height = S__clamp((wininfo.height * scale)->round()->float2nr(), 1, wininfo.height)
  var popup_offset = S__clamp(((wininfo.topline - 1) * scale)->round()->float2nr(), 0, wininfo.height - popup_height)

  popup_setoptions(s_state.popup_id, {
    col: wininfo.wincol + wininfo.width - g:elevator#width,
    line: wininfo.winrow + wininfo.winbar + popup_offset,
    minheight: popup_height,
  })
enddef

def S__on_mouse(event__a: string)
  var mousepos = getmousepos()
  if event__a == 'LeftMouse' && mousepos.winid == s_state.popup_id
    s_state.screenrow = mousepos.screenrow
    s_state.topline = line('w0')
    s_state.dragging = true
    s_state.scrolloff = &scrolloff
    &scrolloff = 0
    S__stop_timer()
    win_gotoid(s_state.scrolled_winid)
    popup_setoptions(s_state.popup_id, {dragall: false})
  elseif event__a == 'LeftDrag' && s_state.dragging
    var delta = mousepos.screenrow - s_state.screenrow
    var savedview = winsaveview()
    var scale = S__calculate_scale(s_state.scrolled_winid)
    savedview.topline = S__clamp(s_state.topline + (delta / scale)->round()->float2nr(), 1, line('$'))
    savedview.lnum = S__clamp(savedview.lnum, savedview.topline, savedview.topline + line('w$') - line('w0'))
    winrestview(savedview)
    S__set_geometry()
  elseif event__a == 'LeftRelease' && s_state.dragging
    s_state.dragging = false
    s_state.screenrow = -1
    s_state.topline = -1
    &scrolloff = s_state.scrolloff
    s_state.scrolloff = -1
    S__restart_timer()
    popup_setoptions(s_state.popup_id, {dragall: true})
  endif
enddef

noremap <LeftDrag>       <LeftDrag><ScriptCmd>S__on_mouse('LeftDrag')<CR>
noremap <LeftMouse>     <LeftMouse><ScriptCmd>S__on_mouse('LeftMouse')<CR>
noremap <LeftRelease> <LeftRelease><ScriptCmd>S__on_mouse('LeftRelease')<CR>
