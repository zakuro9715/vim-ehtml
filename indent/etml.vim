" Vim indent file
" Language: etml
" Maintainer: YuZakuro <zakuro@yuzakuro.me>
" Last Change: 2015 Sep 06

if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

let s:keepcpo= &cpo
set cpo&vim

setlocal indentexpr=GetEtmlIndent(v:lnum)
setlocal indentkeys=o,O,*<Return>,<>>,<<>,/,{,}


if !exists('b:etml_noindent_tags')
  " <list:item>
  "   <i: item1>
  "   <i: item2>
  " </list>
  "
  " <declaration:calculation>
  "   <pls:敗残者の物語>
  "   <pls:脱走者の物語>
  "   <eql:つまりわたし>
  " </declaration>
  "
  " <question>
  "   <q:question>
  "   <a:answer>
  " </question>
  "
  " <definition>
  "   <i:大人になること、それは>
  "   <d:WatchMe を身体に入れて>
  "   <d:どこかの生府の構成員になって>
  " <definition>
  let b:etml_noindent_tags = ['a', 'd', 'ex', 'pls', 'q', 'i']
endif

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
