" sad.vim - simplify visual search
" Maintainer: Hauleth <lukasz@niemier.pl>

if exists('g:loaded_sad_vim') || v:version < 700 || &cp
    finish
endif
let g:loaded_sad_vim = 1
let s:save_cpo = &cpo
set cpo&vim

nnoremap <silent> <Plug>(sad-enable-hlsearch) :<C-u>let v:hlsearch=1<CR>

xnoremap <silent> <Plug>(sad-search-forward) :<C-u>call sad#search_forward(visualmode(), 1)<CR>
xnoremap <silent> <Plug>(sad-search-backward) :<C-u>call sad#search_backward(visualmode(), 1)<CR>

nnoremap <silent> <Plug>(sad-search-forward) :<C-u>set opfunc=sad#search_forward<CR>g@
nnoremap <silent> <Plug>(sad-search-backward) :<C-u>set opfunc=sad#search_backward<CR>g@

xnoremap <silent> <Plug>(sad-change-forward) :<C-u>call sad#search_and_replace_forward(visualmode(), 1)<CR>
xnoremap <silent> <Plug>(sad-change-backward) :<C-u>call sad#search_and_replace_backward(visualmode(), 1)<CR>

nnoremap <expr><silent> <Plug>(sad-change-forward) ':<C-u>set opfunc=sad#search_and_replace_forward<CR>"'.v:register.'g@'
nnoremap <expr><silent> <Plug>(sad-change-backward) ':<C-u>set opfunc=sad#search_and_replace_backward<CR>"'.v:register.'g@'

func! s:trymap(mode, lhs, rhs) abort
    if maparg(a:lhs, a:mode) ==# ''
        exec a:mode.'map <unique> '.a:lhs.' '.a:rhs
    endif
endfunc

if !hasmapto('<Plug>(sad-search-forward)') && !hasmapto('<Plug>(sad-search-backward)')
    call s:trymap('x', '*', '<Plug>(sad-search-forward)')
    call s:trymap('x', '#', '<Plug>(sad-search-backward)')
endif

if !hasmapto('<Plug>(sad-change-forward)') && !hasmapto('<Plug>(sad-change-backward)')
    call s:trymap('x', 's', '<Plug>(sad-change-forward)')
    call s:trymap('x', 'S', '<Plug>(sad-change-backward)')

    call s:trymap('n', 's', '<Plug>(sad-change-forward)')
    call s:trymap('n', 'S', '<Plug>(sad-change-backward)')
endif

nmap <expr> <Plug>(sad-change-forward-linewise) '0"'.v:register.'<Plug>(sad-change-forward)'.v:count1.'g_'
nmap <expr> <Plug>(sad-change-backward-linewise) '0"'.v:register.'<Plug>(sad-change-backward)'.v:count1.'g_'

command! -bang Sad call sad#be_happy(<bang>0)

let &cpo = s:save_cpo
unlet s:save_cpo
