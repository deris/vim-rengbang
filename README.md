vim-rengbang
===

This is Vim plugin for sequencial numbering with pattern.

Usage
---

### Commands
```vim
" Select text linewise and you can use following command
" for sequential numbering (in Japanese called rengbang).

" Sequential numbering use default settings(ref. global variables).
:'<,'>RengBang
" Specify pattern like this. This sample is for array index.
:'<,'>RengBang \[\(\d\+\)\]
" Start sequencial numbering from 3.
:'<,'>RengBang \[\(\d\+\)\] 3
" Start from 3 and 2 step.
:'<,'>RengBang \[\(\d\+\)\] 0  2
" Start position use first detected number.
:'<,'>RengBang \[\(\d\+\)\] 0  1  1

" You can use previous command options.
:'<,'>RengBangUsePrev
" Use previous pattern and set other options.
:'<,'>RengBangUsePrev 1 1 0
```

### Functions
```vim
" You can use function same as commands, all parameter is option.
" This is function's format.
"   rengbang#rengbang([pattern, start, step, use_first])
"   rengbang#rengbang_use_prev([start, step, use_first])

" This is like :'<,'>RengBang \[\(\d\+\)\] 0  1  1
:'<,'>call rengbang#rengbang('\[\(\d\+\)\]', 0, 1, 1)
" This is like :'<,'>RengBangUsePrev 1 1 0
:'<,'>call rengbang#rengbang_use_prev(1, 1, 0)

```

### Global variables
```vim
" If you want to customize default settings,
" you can change following gloval variable.

" Following settings is default value.
let g:rengbang_default_pattern  = '\(\d\+\)'
let g:rengbang_default_start    = 0
let g:rengbang_default_step     = 1
let g:rengbang_default_usefirst = 0
```

### Operators
```vim
" You can use following operator.

" This operator like :'<,'>RengBang (use default options).
map <Leader>sr <Plug>(operator-rengbang)
" This operator like :'<,'>RengBangUsePrev (use previous options).
map <Leader>sp <Plug>(operator-rengbang-useprev)
```

