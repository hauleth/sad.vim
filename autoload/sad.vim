function! sad#search(type, ...)
    let l:temp = @v
    if a:0
        silent exe 'norm! gv"vy'
    elseif a:type ==# 'line'
        silent exe "normal! '[V']\"vy"
    else
        silent exe 'normal! `[v`]"vy'
    endif

    let l:search = @v
    let @v = l:temp
    let @/ = '\V\C' . substitute(escape(l:search, '\'), '\n', '\\n', 'g')
    call histadd('/', substitute(@/, '[?/]', '\="\\%d".char2nr(submatch(0))', 'g'))
    let &hlsearch = 1

    return l:search
endfunction

function! sad#search_forward(type, ...)
    call call('sad#search', [a:type] + a:000)
    call feedkeys("/\<CR>", 'n')
endfunction

function! sad#search_backward(type, ...)
    call call('sad#search', [a:type] + a:000)
    call feedkeys("?\<CR>", 'n')
endfunction

function! sad#search_and_replace_forward(type, ...)
    if visualmode() ==# ''
        call feedkeys('gv"'.v:register.'c', 'n')
        return
    endif
    let l:search = call('sad#search', [a:type] + a:000)
    exe 'let @'.v:register.' = "'.escape(l:search, '"').'"'
    call feedkeys('"'.v:register.'cgn', 'n')
endfunction

function! sad#search_and_replace_backward(type, ...)
    if visualmode() ==# ''
        call feedkeys('gv"'.v:register.'c', 'n')
        return
    endif
    let l:search = call('sad#search', [a:type] + a:000)
    exe 'let @'.v:register.' = "'.escape(l:search, '"').'"'
    call feedkeys('"'.v:register.'cgN', 'n')
endfunction

function! sad#be_happy(bang)
    if a:bang
        echom "Be happy now."
    else
        echom "Don't worry, be happy!"
    endif
endfunction
