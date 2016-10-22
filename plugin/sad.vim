" sad.vim - simplify visual search
" Maintainer:   Łukasz Niemier <http://lukasz.niemier.pl>

scriptencoding utf-8

if exists('g:loaded_vsearch') || v:version < 700 || &cp
  finish
endif
let g:loaded_vsearch = 1
let s:save_cpo = &cpo
set cpo&vim

xnoremap <Plug>(sad-search-selected-forward) :<C-u>call sad#vsearch(visualmode(), 1)<CR>/<CR>
xnoremap <Plug>(sad-search-selected-backward) :<C-u>call sad#vsearch(visualmode(), 1)<CR>?<CR>

xnoremap <Plug>(sad-change-selected-forward) :<C-u>call sad#vsearch(visualmode(), 1)<CR>:set hlsearch<CR>cgn
xnoremap <Plug>(sad-change-selected-backward) :<C-u>call sad#vsearch(visualmode(), 1)<CR>:set hlsearch<CR>cgN

nnoremap <Plug>(sad-change-word-forward) :set operatorfunc=sad#vsearch_and_replace_forward<CR>g@
nnoremap <Plug>(sad-change-word-backward) :set operatorfunc=sad#vsearch_and_replace_backward<CR>g@

xmap * <Plug>(sad-search-selected-forward)
xmap # <Plug>(sad-search-selected-backward)

xmap s <Plug>(sad-change-selected-forward)
xmap S <Plug>(sad-change-selected-backward)

nmap s <Plug>(sad-change-word-forward)
nmap S <Plug>(sad-change-word-backward)

nmap ss Vs
nmap SS VS

command! -bang Sad call sad#be_happy(<bang>0)

let &cpo = s:save_cpo
