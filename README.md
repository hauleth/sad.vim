# Seek and Destroy

Simple Vim plugin that allows you to quickly search and replace occurrences of
text.

## FAQ

### But what about default `s` and `S` behaviour?

Just use `c_` or `cc`.

### But what about interference between this and [vim-sneak][]?

Create your own maps:

```vim
nmap <leader>s <Plug>(sad-change-word-forward)
nmap <leader>S <Plug>(sad-change-word-backward)
```

### Are there any easter eggs about name?

Not yet. And ever if there would be, then what is the point in telling you
anyway?
