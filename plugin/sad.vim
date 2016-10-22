" sad.vim - simplify visual search
" Maintainer:   Łukasz Niemier <http://lukasz.niemier.pl>

scriptencoding utf-8

if exists('g:loaded_vsearch') || v:version < 700 || &cp
  finish
endif
let g:loaded_vsearch = 1
let s:save_cpo = &cpo
set cpo&vim

xnoremap <silent> <Plug>(sad-search-selected-forward) :<C-u>call sad#search(visualmode(), 1)<CR>/<CR>
xnoremap <silent> <Plug>(sad-search-selected-backward) :<C-u>call sad#search(visualmode(), 1)<CR>?<CR>

xnoremap <expr><silent> <Plug>(sad-change-selected-forward) ':<C-u>call sad#search(visualmode(), 1)<CR>"'.v:register.'cgn'
xnoremap <expr><silent> <Plug>(sad-change-selected-backward) ':<C-u>call sad#search(visualmode(), 1)<CR>"'.v:register.'cgN'

nnoremap <expr><silent> <Plug>(sad-change-movement-forward) ':<C-u>set opfunc=sad#search_and_replace_forward<CR>"'.v:register.'g@'
nnoremap <expr><silent> <Plug>(sad-change-movement-backward) ':<C-u>set opfunc=sad#search_and_replace_forward<CR>"'.v:register.'g@'

xmap * <Plug>(sad-search-selected-forward)
xmap # <Plug>(sad-search-selected-backward)

xmap s <Plug>(sad-change-selected-forward)
xmap S <Plug>(sad-change-selected-backward)

nmap s <Plug>(sad-change-movement-forward)
nmap S <Plug>(sad-change-movement-backward)

nmap <expr> ss '0"'.v:register.'<Plug>(sad-change-movement-forward)'.v:count1.'g_'
nmap <expr> SS '0"'.v:register.'<Plug>(sad-change-movement-backward)'.v:count1.'g_'

command! -bang Sad call sad#be_happy(<bang>0)

let &cpo = s:save_cpo
