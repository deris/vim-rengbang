vim-rengbang
===
[![Build Status](https://travis-ci.org/deris/vim-rengbang.svg?branch=master)](https://travis-ci.org/deris/vim-rengbang)
[![Build status](https://ci.appveyor.com/api/projects/status/m21v0ldpvscg1ikh?svg=true)](https://ci.appveyor.com/project/deris/vim-rengbang)

This is Vim plugin for sequencial numbering with pattern.

Screenshot
---

### input 0-99

![screenshot1](https://raw.githubusercontent.com/deris/s/master/vim-rengbang/vim-rengbang_01_input0-99.gif)

### insert sequencial number to head of line

![screenshot2](https://raw.githubusercontent.com/deris/s/master/vim-rengbang/vim-rengbang_02_sequencial_number.gif)

### insert sequencial number before 'foo'

![screenshot3](https://raw.githubusercontent.com/deris/s/master/vim-rengbang/vim-rengbang_03_before_foo.gif)

### revise sequencial number when array index is slanted

![screenshot4](https://raw.githubusercontent.com/deris/s/master/vim-rengbang/vim-rengbang_04_revice_array_index.gif)

### specify format for sequencial number
![screenshot5](https://raw.githubusercontent.com/deris/s/master/vim-rengbang/vim-rengbang_05_specify_format.gif)

### RengBangConfirm is confirming option at Command-line
![screenshot6](https://raw.githubusercontent.com/deris/s/master/vim-rengbang/vim-rengbang_06_rengbangconfirm.gif)

### use option style
![screenshot7](https://raw.githubusercontent.com/deris/s/master/vim-rengbang/vim-rengbang_07_use_option.gif)

### use both argument and option
![screenshot8](https://raw.githubusercontent.com/deris/s/master/vim-rengbang/vim-rengbang_08_use_arg_and_option.gif)


Usage
---

### Commands
```vim
" Select text linewise and you can use following command
" for sequencial numbering (in Japanese called rengbang).

" Sequencial numbering use default settings(ref. global variables).
:'<,'>RengBang
" Specify pattern like this. This sample is for array index.
:'<,'>RengBang \[\zs\(\d\+\)\ze\]
" Start sequencial numbering from 3.
:'<,'>RengBang \(\d\+\)  3
" Start from 3 and 2 step.
:'<,'>RengBang \(\d\+\)  0  2
" Start position use first detected number.
:'<,'>RengBang \(\d\+\)  0  1  1
" Use format %03d for replacing to sequencial number like '001.'.
:'<,'>RengBang \(\d\+\)  0  1  0  %03d.
" Use option same as above
:'<,'>RengBang --pattern=\(\d\+\) --start-number=0 --step-count=1 --format=%03d.
" You can specify both argument and options
:'<,'>RengBang \(\d\+\) 0 --format=%03d. --use-first

" You can use previous command options.
:'<,'>RengBangUsePrev
" Use previous pattern and set other options.
:'<,'>RengBangUsePrev  0  1  0  %d
```

### Functions
```vim
" You can use function same as commands, all parameter is option.
" This is function's format.
"   rengbang#rengbang([pattern, start, step, usefirst, format])
"   rengbang#rengbang_use_prev([start, step, usefirst, format])
"   rengbang#rengbang_confirm()

" This is like :'<,'>RengBang \(\d\+\)  0  1  1  %d
:'<,'>call rengbang#rengbang('\(\d\+\)', 0, 1, 1, '%d')
" This is like :'<,'>RengBangUsePrev  1  1  0  %d
:'<,'>call rengbang#rengbang_use_prev(1, 1, 0, '%d')
" This is like :'<,'>RengBangConfirm
:'<,'>call rengbang#rengbang_confirm()

" You can use this function for customizing default settings.
" This is functions format
"   rengbang#config([pattern, start, step, usefirst, format])

" This is only config settings without sequencial numbering.
:call rengbang#config('\(\d\+\)', 0, 1, 1, '%d')
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
let g:rengbang_default_confirm_sequence = [
  \ 'pattern',
  \ 'start',
  \ 'step',
  \ 'usefirst',
  \ 'format',
  \ ]
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

