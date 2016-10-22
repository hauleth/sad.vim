function! sad#vsearch(type, ...)
  let l:temp = @@
  if a:0
    silent exe 'norm! gvy'
  elseif a:type ==# 'line'
    silent exe "normal! '[V']y"
  else
    silent exe 'normal! `[v`]y'
  endif

  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  call histadd('/', substitute(@/, '[?/]', '\="\\%d".char2nr(submatch(0))', 'g'))
  let @@ = l:temp
  set hlsearch
endfunction

function! sad#vsearch_and_replace_forward(type, ...)
  call call('sad#vsearch', [a:type] + a:000)
  call feedkeys('cgn', 'n')
endfunction

function! sad#vsearch_and_replace_backward(type, ...)
  call call('sad#vsearch', [a:type] + a:000)
  call feedkeys('cgN', 'n')
endfunction

function! sad#be_happy(bang)
  if a:bang
    echom "Be happy now."
  else
    echom "Don't worry, be happy!"
  endif
endfunction
