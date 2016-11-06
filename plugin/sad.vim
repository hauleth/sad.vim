" sad.vim - simplify visual search
" Maintainer:   Łukasz Niemier <http://lukasz.niemier.pl>

scriptencoding utf-8

if exists('g:loaded_sad_vim') || v:version < 700 || &cp
  finish
endif
let g:loaded_sad_vim = 1
let s:save_cpo = &cpo
set cpo&vim

xnoremap <silent> <Plug>(sad-search-forward) :<C-u>call sad#search_forward(visualmode(), 1)<CR>
xnoremap <silent> <Plug>(sad-search-backward) :<C-u>call sad#search_backward(visualmode(), 1)<CR>

nnoremap <silent> <Plug>(sad-search-forward) :<C-u>set opfunc=sad#search_forward<CR>g@
nnoremap <silent> <Plug>(sad-search-backward) :<C-u>set opfunc=sad#search_backward<CR>g@

xnoremap <silent> <Plug>(sad-change-forward) :<C-u>call sad#search_and_replace_forward(visualmode(), 1)<CR>
xnoremap <silent> <Plug>(sad-change-backward) :<C-u>call sad#search_and_replace_backward(visualmode(), 1)<CR>

nnoremap <expr><silent> <Plug>(sad-change-forward) ':<C-u>set opfunc=sad#search_and_replace_forward<CR>"'.v:register.'g@'
nnoremap <expr><silent> <Plug>(sad-change-backward) ':<C-u>set opfunc=sad#search_and_replace_backward<CR>"'.v:register.'g@'

if !hasmapto('<Plug>(sad-search-forward)') || !hasmapto('<Plug>(sad-search-backward)')
  if mapcheck('*', 'x') ==# ""
    xmap * <Plug>(sad-search-forward)
  endif
  if mapcheck('#', 'x') ==# ""
    xmap # <Plug>(sad-search-backward)
  endif
endif

if !hasmapto('<Plug>(sad-change-forward)') || !hasmapto('<Plug>(sad-change-backward)')
  if mapcheck('s', 'x') ==# ""
    xmap s <Plug>(sad-change-forward)
  endif
  if mapcheck('S', 'x') ==# ""
    xmap S <Plug>(sad-change-backward)
  endif

  if mapcheck('s', 'n') ==# ""
    nmap s <Plug>(sad-change-forward)
  endif
  if mapcheck('S', 'n') ==# ""
    nmap S <Plug>(sad-change-backward)
  endif

  if mapcheck('ss', 'n') ==# ""
    nmap <expr> ss '0"'.v:register.'<Plug>(sad-change-forward)'.v:count1.'g_'
  endif
  if mapcheck('SS', 'n') ==# ""
    nmap <expr> SS '0"'.v:register.'<Plug>(sad-change-backward)'.v:count1.'g_'
  endif
endif

command! -bang Sad call sad#be_happy(<bang>0)

let &cpo = s:save_cpo
