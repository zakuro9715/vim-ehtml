" Vim indent file
" Language: etml
" Maintainer: YuZakuro <zakuro@yuzakuro.me>
" Last Change: 2015 Sep 05

if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

let s:keepcpo= &cpo
set cpo&vim

setlocal indentexpr=GetEtmlIndent(v:lnum)
setlocal indentkeys=o,O,*<Return>,<>>,<<>,/,{,}


if !exists('b:etml_indent_open')
  let b:etml_indent_open = '.\{-}<\a'
endif

if !exists('b:etml_indent_close')
  let b:etml_indent_close = '.\{-}</'
endif


if exists('*GetEtmlIndent')
  finish
endif


let s:keepcpo= &cpo
set cpo&vim

fun! <SID>GetEtmlIndentWithPattern(line, pat)
  echo pat
  let s = substitute('x'.a:line, a:pat, "\1", 'g')
  return strlen(substitute(s, "[^\1].*$", '', ''))
endfun

fun! <SID>GetEtmlIndentSum(lnum, style, base)
  let line = getline(a:lnum)
  if a:style == match(line, '^\s*</')
    return a:base + (&sw * (
          \ <SID>GetEtmlIndentWithPattern(line, b:etml_indent_open) -
          \ <SID>GetEtmlIndentWithPattern(line, b:etml_indent_close) -
          \ <SID>GetEtmlIndentWithPattern(line, '.\{-}/>')))
  else
    return a:base
  endif
endfun

fun! GetEtmlIndent(lnum)
  let lnum = prevnonblank(a:lnum - 1)
  if lnum == 0
    return 0
  endif

  let ind = <SID>GetEtmlIndentSum(lnum, -1, indent(lnum))
  let ind = <SID>GetEtmlIndentSum(a:lnum, 0, ind)
  return ind
endfun

let &cpo = s:keepcpo
unlet s:keepcpo
