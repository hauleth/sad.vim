function! sad#search(type, ...)
  let l:temp = @@
  if a:0
    silent exe 'norm! gvy'
  elseif a:type ==# 'line'
    silent exe "normal! '[V']y"
  else
    silent exe 'normal! `[v`]y'
  endif

  let l:search = @@
  let @@ = l:temp
  let @/ = '\V' . substitute(escape(l:search, '\'), '\n', '\\n', 'g')
  call histadd('/', substitute(@/, '[?/]', '\="\\%d".char2nr(submatch(0))', 'g'))
  set hlsearch

  return l:search
endfunction

function! sad#search_and_replace_forward(type, ...)
  let l:reg = v:register
  let l:search = call('sad#search', [a:type] + a:000)
  exe 'let @'.l:reg.' = "'.escape(l:search, '"').'"'
  call feedkeys('"_cgn', 'n')
endfunction

function! sad#search_and_replace_backward(type, ...)
  let l:reg = v:register
  let l:search = call('sad#search', [a:type] + a:000)
  exe 'let @'.l:reg.' = "'.escape(l:search, '"').'"'
  call feedkeys('"_cgN', 'n')
endfunction

function! sad#be_happy(bang)
  if a:bang
    echom "Be happy now."
  else
    echom "Don't worry, be happy!"
  endif
endfunction
