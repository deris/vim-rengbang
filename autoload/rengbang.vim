" rengbang - 連番入力補助plugin
" Version: 0.0.0
" Author: manga_osyo, deris0126
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
function! rengbang#rengbang(...) range
  call s:rengbang(a:000, a:firstline, a:lastline)
endfunction

function! rengbang#rengbang_use_prev(...) range
  call s:rengbang_use_prev(a:000, a:firstline, a:lastline)
endfunction

function! rengbang#config(...)
  call s:config(a:000)
endfunction
"}}}

" Private {{{1
function! s:rengbang(options, fline, lline)
  if len(a:options) > 4
    return
  endif

  let pattern = get(a:options, 0, '') == '' ? g:rengbang_default_pattern : a:options[0]
  let s:start = get(a:options, 1, g:rengbang_default_start)
  let s:step  = get(a:options, 2, g:rengbang_default_step)
  let s:usefirst  = get(a:options, 3, g:rengbang_default_usefirst)

  let s:prev_pattern = pattern
  let s:prev_start = s:start
  let s:prev_step = s:step
  let s:prev_usefirst = s:usefirst

  let s:counter = 0
  if exists('s:first_number')
    unlet s:first_number
  endif

  let pattern = s:normalize_pattern(pattern)
  silent execute printf('%s,%ssubstitute/%s/\=s:matched(submatch(1))/g', a:fline, a:lline, pattern)
endfunction

function! s:rengbang_use_prev(options, fline, lline)
  if len(a:options) > 3
    return
  endif

  let pattern = get(s:, 'prev_pattern', g:rengbang_default_pattern)
  let start = get(a:options, 0, get(s:, 'prev_start', g:rengbang_default_start))
  let step  = get(a:options, 1, get(s:, 'prev_step', g:rengbang_default_step))
  let usefirst = get(a:options, 2, get(s:, 'prev_usefirst', g:rengbang_default_usefirst))

  call s:rengbang([pattern, start, step, usefirst], a:fline, a:lline)
endfunction

function! s:config(options)
  if len(a:options) > 4
    return
  endif

  let g:rengbang_default_pattern = get(a:options, 0, '') == '' ? g:rengbang_default_pattern : a:options[0]
  let g:rengbang_default_start = get(a:options, 1, g:rengbang_default_start)
  let g:rengbang_default_step  = get(a:options, 2, g:rengbang_default_step)
  let g:rengbang_default_usefirst  = get(a:options, 3, g:rengbang_default_usefirst)
endfunction

function! s:matched(match)
  if !exists('s:first_number')
    let s:first_number = s:usefirst != 0 ?
      \ a:match : 0
  endif

  return s:first_number + s:start + s:step()
endfunction

function! s:step()
  let tmp = s:counter
  let s:counter += s:step
  return tmp
endfunction

function! s:normalize_pattern(pattern)
  let pattern = a:pattern
  let pattern = substitute(pattern, '\%(\\zs\)\@<!\\(', '\\zs\\(', 'g')
  let pattern = substitute(pattern, '\\)\%(\\ze\)\@!', '\\)\\ze', 'g')
  return pattern
endfunction
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" __END__ "{{{1
" vim: foldmethod=marker
