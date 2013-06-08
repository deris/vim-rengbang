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

let s:save_cpo = &cpo
set cpo&vim

" Public API {{{1

"}}}

" Private {{{1
function! s:rengbang(pattern, ...)
  if a:0 > 2
    return
  endif

  let s:start = get(a:, 1, get(g:, 'rengbang_default_start', 0))
  let s:step  = get(a:, 2, get(g:, 'rengbang_default_step', 1))

  let pattern = empty(a:pattern) ? get(g, 'rengbang_default_pattern', '\(\d\+\)') : a:pattern

  let s:counter = 0

  silent execute "'<,'>s/".pattern.'/\=s:matched(submatch(1))/g'
endfunction

function! s:matched(match)
  if get(g:, 'rengbang_use_first_number', 0)
    let s:first_number = a:match
  else
    let s:first_number = 0
  endif

  return s:first_number + s:start + s:step()
endfunction

function! s:step()
  let tmp = s:counter
  let s:counter += s:step
  return tmp
endfunction
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" __END__ "{{{1
" vim: foldmethod=marker
