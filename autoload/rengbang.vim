" rengbang - Vim plugin for sequencial numbering with pattern
" Version: 1.1.0
" Author: manga_osyo, deris0126
" Copyright (C) 2013-2015 deris <deris0126@gmail.com>
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

" vital
let s:V = vital#of('vim_rengbang')
let s:O = s:V.import('OptionParser')
let s:parser_rengbang = s:O.new()
let s:parser_rengbang_use_prev = s:O.new()
let s:parser_rengbang.disable_auto_help = 1
let s:parser_rengbang_use_prev.disable_auto_help = 1


" Public API {{{1
function! rengbang#rengbang(...) range
  call s:rengbang(a:000, a:firstline, a:lastline)
endfunction

function! rengbang#rengbang_use_prev(...) range
  call s:rengbang_use_prev(a:000, a:firstline, a:lastline)
endfunction

function! rengbang#rengbang_confirm() range
  call s:rengbang_confirm(a:firstline, a:lastline)
endfunction

function! rengbang#config(...)
  call s:config(a:000)
endfunction

function! rengbang#complete_rengbang(arglead, cmdline, cursorpos)
  return s:parser_rengbang.complete(a:arglead, a:cmdline, a:cursorpos)
endfunction

function! rengbang#complete_rengbang_use_prev(arglead, cmdline, cursorpos)
  return s:parser_rengbang_use_prev.complete(a:arglead, a:cmdline, a:cursorpos)
endfunction
"}}}

" Private {{{1

" define options
call s:parser_rengbang.on('--pattern=VALUE', 'specify pattern for replacing to sequencial number',
  \ {'default' : g:rengbang_default_pattern})
call s:parser_rengbang.on('--start-number=VALUE', 'start number of sequencial number',
  \ {'default' : g:rengbang_default_start})
call s:parser_rengbang.on('--step-count=VALUE', 'step count of sequencial number',
  \ {'default' : g:rengbang_default_step})
call s:parser_rengbang.on('--use-first', 'specify if you want to use first matched number as start number',
  \ {'default' : g:rengbang_default_usefirst})
call s:parser_rengbang.on('--format=VALUE', 'format of sequencial number. you can use printf style format like %d and %x',
  \ {'default' : g:rengbang_default_format})

call s:parser_rengbang_use_prev.on('--start-number=VALUE', 'start number of sequencial number',
  \ {'default' : g:rengbang_default_start})
call s:parser_rengbang_use_prev.on('--step-count=VALUE', 'step count of sequencial number',
  \ {'default' : g:rengbang_default_step})
call s:parser_rengbang_use_prev.on('--use-first', 'specify if you want to use first matched number as start number',
  \ {'default' : g:rengbang_default_usefirst})
call s:parser_rengbang_use_prev.on('--format=VALUE', 'format of sequencial number. you can use printf style format like %d and %x',
  \ {'default' : g:rengbang_default_format})

" functions
function! s:rengbang(cmd_args, fline, lline)
  let parsed_args = call(s:parser_rengbang.parse, a:cmd_args, s:parser_rengbang)
  if empty(get(parsed_args, '__unknown_args__', []))
    " only '--' style options specified or no args specified
    let a:options = [
      \ parsed_args['pattern'],
      \ parsed_args['start-number'],
      \ parsed_args['step-count'],
      \ parsed_args['use-first'],
      \ parsed_args['format'],
      \ ]
  else
    let a:options = parsed_args.__unknown_args__
  endif

  if len(a:options) > 5
    return
  endif

  let pattern = get(a:options, 0, '') == '' ? g:rengbang_default_pattern : a:options[0]
  let s:start = get(a:options, 1, g:rengbang_default_start)
  let s:step  = get(a:options, 2, g:rengbang_default_step)
  let s:usefirst  = get(a:options, 3, g:rengbang_default_usefirst)
  let s:format  = get(a:options, 4, g:rengbang_default_format)

  let s:prev_pattern = pattern
  let s:prev_start = s:start
  let s:prev_step = s:step
  let s:prev_usefirst = s:usefirst
  let s:prev_format = s:format

  let s:counter = 0
  if exists('s:first_number')
    unlet s:first_number
  endif

  let pattern = s:normalize_pattern(pattern)
  silent execute printf('%s,%ssubstitute/%s/\=s:matched(submatch(1))/g', a:fline, a:lline, pattern)
endfunction

function! s:rengbang_use_prev(cmd_args, fline, lline)
  let parsed_args = call(s:parser_rengbang_use_prev.parse, a:cmd_args, s:parser_rengbang_use_prev)
  if empty(get(parsed_args, '__unknown_args__', []))
    " only '--' style options specified or no args specified
    let a:options = [
      \ parsed_args['start-number'],
      \ parsed_args['step-count'],
      \ parsed_args['use-first'],
      \ parsed_args['format'],
      \ ]
  else
    let a:options = parsed_args.__unknown_args__
  endif

  if len(a:options) > 4
    return
  endif

  let pattern = get(s:, 'prev_pattern', g:rengbang_default_pattern)
  let start = get(a:options, 0, get(s:, 'prev_start', g:rengbang_default_start))
  let step  = get(a:options, 1, get(s:, 'prev_step', g:rengbang_default_step))
  let usefirst = get(a:options, 2, get(s:, 'prev_usefirst', g:rengbang_default_usefirst))
  let format = get(a:options, 3, get(s:, 'prev_format', g:rengbang_default_format))

  call s:rengbang([join([pattern, start, step, usefirst, format], ' ')], a:fline, a:lline)
endfunction

function! s:rengbang_confirm(fline, lline)
  for option in g:rengbang_default_confirm_sequence
    if option == 'pattern'
      let pattern = input('Pattern: ', g:rengbang_default_pattern)
      if empty(pattern)
        break
      endif
    elseif option == 'start'
      let start = input('Start Number: ', g:rengbang_default_start)
      if empty(start)
        break
      endif
    elseif option == 'step'
      let step = input('Step Count: ', g:rengbang_default_step)
      if empty(step)
        break
      endif
    elseif option == 'usefirst'
      let usefirst = input('Use First: ', g:rengbang_default_usefirst)
      if empty(usefirst)
        break
      endif
    elseif option == 'format'
      let format = input('Format: ', g:rengbang_default_format)
      if empty(format)
        break
      endif
    endif
  endfor

  redraw!

  let pattern  = exists('pattern')  && !empty(pattern)  ? pattern  : g:rengbang_default_pattern
  let start    = exists('start')    && !empty(start)    ? start    : g:rengbang_default_start
  let step     = exists('step')     && !empty(step)     ? step     : g:rengbang_default_step
  let usefirst = exists('usefirst') && !empty(usefirst) ? usefirst : g:rengbang_default_usefirst
  let format   = exists('format')   && !empty(format)   ? format   : g:rengbang_default_format

  call s:rengbang([join([pattern, start, step, usefirst, format], ' ')], a:fline, a:lline)
endfunction

function! s:config(options)
  if len(a:options) > 5
    return
  endif

  let g:rengbang_default_pattern = get(a:options, 0, '') == '' ? g:rengbang_default_pattern : a:options[0]
  let g:rengbang_default_start = get(a:options, 1, g:rengbang_default_start)
  let g:rengbang_default_step  = get(a:options, 2, g:rengbang_default_step)
  let g:rengbang_default_usefirst  = get(a:options, 3, g:rengbang_default_usefirst)
  let g:rengbang_default_format  = get(a:options, 4, g:rengbang_default_format)
endfunction

function! s:matched(match)
  if !exists('s:first_number')
    let s:first_number = s:usefirst != 0 ?
      \ a:match : 0
  endif

  return printf(s:format, s:first_number + s:start + s:step())
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
