function! sad#search(type, ...) abort
    let l:temp = @v
    if a:0
        silent exe 'norm! gv"vy'
    elseif a:type is# 'line'
        silent exe "normal! '[V']\"vy"
    else
        silent exe 'normal! `[v`]"vy'
    endif

    let l:search = @v
    let @v = l:temp
    let @/ = '\V\C' . substitute(escape(l:search, '\'), '\n', '\\n', 'g')
    call histadd('/', substitute(@/, '[?/]', '\="\\%d".char2nr(submatch(0))', 'g'))
    call feedkeys("\<Plug>(sad-enable-hlsearch)")

    return l:search
endfunction

function! sad#search_forward(...) abort
    call call('sad#search', a:000)
    call feedkeys("/\<CR>", 'n')
endfunction

function! sad#search_backward(...) abort
    call call('sad#search', a:000)
    call feedkeys("?\<CR>", 'n')
endfunction

function! s:search_and_replace(dir, ...) abort
    if visualmode() is# ''
        call feedkeys('gv"'.v:register.'c', 'n')
        return
    endif

    let l:search = call('sad#search', a:000)
    exe 'let @'.v:register.' = "'.escape(l:search, '"').'"'
    call feedkeys('"'.v:register.'cg'.a:dir, 'n')
endfunction

function! sad#search_and_replace_forward(...) abort
    call call('s:search_and_replace', ['n'] + a:000)
endfunction

function! sad#search_and_replace_backward(...) abort
    call call('s:search_and_replace', ['N'] + a:000)
endfunction

function! sad#be_happy(bang) abort
    if a:bang
        echom 'Be happy now.'
    else
        echom "Don't worry, be happy!"
    endif
endfunction
