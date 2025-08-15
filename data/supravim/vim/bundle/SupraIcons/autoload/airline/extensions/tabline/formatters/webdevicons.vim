" Version: 0.11.0
" Webpage: https://github.com/ryanoasis/vim-devicons
" Maintainer: Ryan McIntyre <ryanoasis@gmail.com>
" License: see LICENSE

function! airline#extensions#tabline#formatters#webdevicons#format(bufnr, buffers) abort
  let bufname = bufname(a:bufnr)
  let name = fnamemodify(bufname, ':t')
  if stridx(name, 'suprawater') == 0 && strridx(name, '.water') > 0
    let name = 'SupraWater'
  endif
  return name .. g:WebDevIconsTabAirLineBeforeGlyphPadding . WebDevIconsGetFileTypeSymbol(bufname) . g:WebDevIconsTabAirLineAfterGlyphPadding
endfunction

" modeline syntax:
" vim: fdm=marker tabstop=2 softtabstop=2 shiftwidth=2 expandtab:
