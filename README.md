vim-rengbang
===

This is Vim plugin for sequencial numbering with pattern.

Screenshot
---

### input 0-99

![screenshot1](http://gifzo.net/BDoBAj8f5Fj.gif)

### insert sequencial number to head of line

![screenshot2](http://gifzo.net/i7xgddDAvJ.gif)

### insert sequencial number before 'foo'

![screenshot3](http://gifzo.net/BFp5z1aVuA8.gif)

### revise sequencial number when array index is slanted

![screenshot4](http://gifzo.net/YNLnolfBJK.gif)


Usage
---

### Commands
```vim
" Select text linewise and you can use following command
" for sequential numbering (in Japanese called rengbang).

" Sequential numbering use default settings(ref. global variables).
:'<,'>RengBang
" Specify pattern like this. This sample is for array index.
:'<,'>RengBang \[\zs\(\d\+\)\ze\]
" Start sequencial numbering from 3.
:'<,'>RengBang \[\zs\(\d\+\)\ze\] 3
" Start from 3 and 2 step.
:'<,'>RengBang \[\zs\(\d\+\)\ze\] 0  2
" Start position use first detected number.
:'<,'>RengBang \[\zs\(\d\+\)\ze\] 0  1  1

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

" This is like :'<,'>RengBang \[\zs\(\d\+\)\ze\] 0  1  1
:'<,'>call rengbang#rengbang('\[\zs\(\d\+\)\ze\]', 0, 1, 1)
" This is like :'<,'>RengBangUsePrev 1 1 0
:'<,'>call rengbang#rengbang_use_prev(1, 1, 0)

" You can use this function for customizing default settings.
" This is functions format
"   rengbang#config([pattern, start, step, use_first])

" This is only config settings without sequential numbering.
:call rengbang#config('\[\zs\(\d\+\)\ze\]', 0, 1, 1)
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

### License

MIT License

