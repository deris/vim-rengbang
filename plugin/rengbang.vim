" rengbang - 連番入力補助plugin
" Version: 0.0.0
" Copyright (C) 2013 deris0126
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}

if exists('g:loaded_rengbang')
  finish
endif
let g:loaded_rengbang = 1

let s:save_cpo = &cpo
set cpo&vim



command! -range -nargs=*
  \	RengBang
  \	<line1>,<line2>call rengbang#rengbang(<f-args>)
command! -range -nargs=*
  \	RengBangUsePrev
  \	<line1>,<line2>call rengbang#rengbang_use_prev(<f-args>)

let g:rengbang_default_start    = get(g:, 'rengbang_default_start', 0)
let g:rengbang_default_step     = get(g:, 'rengbang_default_step', 1)
let g:rengbang_default_pattern  = get(g:, 'rengbang_default_pattern', '\(\d\+\)')
let g:rengbang_default_usefirst = get(g:, 'rengbang_default_usefirst', 0)



let &cpo = s:save_cpo
unlet s:save_cpo

" __END__
" vim: foldmethod=marker
