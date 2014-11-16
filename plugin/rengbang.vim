" rengbang - Vim plugin for sequencial numbering with pattern
" Version: 1.0.0
" Author: manga_osyo, deris0126
" Copyright (C) 2013-2014 deris <deris0126@gmail.com>
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
command! -range -nargs=0
  \	RengBangConfirm
  \	<line1>,<line2>call rengbang#rengbang_confirm()

let g:rengbang_default_start    = get(g:, 'rengbang_default_start', 0)
let g:rengbang_default_step     = get(g:, 'rengbang_default_step', 1)
let g:rengbang_default_pattern  = get(g:, 'rengbang_default_pattern', '\(\d\+\)')
let g:rengbang_default_usefirst = get(g:, 'rengbang_default_usefirst', 0)
let g:rengbang_default_format   = get(g:, 'rengbang_default_format', '%d')
let g:rengbang_default_confirm_sequence = [
  \ 'pattern',
  \ 'start',
  \ 'step',
  \ 'usefirst',
  \ 'format',
  \ ]


let &cpo = s:save_cpo
unlet s:save_cpo

" __END__
" vim: foldmethod=marker
