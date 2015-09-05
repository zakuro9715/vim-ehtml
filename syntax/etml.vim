" Vim syntax file
" Language: ETML
" Maintainer: YuZakuro <zakuro@yuzakuro.me>
" Last Change: 2015 Sep 05

if exists('b:current_syntax')
  finish
endif


let s:keepcpo = &cpo
set cpo&vim

syn case ignore

syn region etmlString start=+"+ end=+"+ contained
syn region etmlString start=+'+ end=+'+ contained

syn region etmlTag
      \ start=+<[^ /!?:=>]\@=+
      \ end=+>+
      \ contains=etmlTagName,etmlTagAttribute,etmlTagAttributeValue
syn match etmlTagName +\(<[/?]\?\)\@<=[^/!?:=>]\++ contained
syn match etmlTagEnd +</\a\+>+
      \ contains=etmlTagName
syn region etmlTagAttribute contained
      \ start=+:+ms=s+1
      \ end=+[:>=]+me=e-1
syn region etmlTagAttributeValue contained
      \ start=+=+ms=s+1
      \ end=+[:>?]+me=e-1
      \ contains=etmlString

syn region etmlComment
      \ start=+<!+
      \ end=+>+
      \ contains=etmlCommentStart,etmlCommentPart,etmlCommentError
syn match etmlCommentStart +<!+ contained
syn match etmlCommentError +[^<>!]+ contained
syn region etmlCommentPart contained
      \ start=+--+
      \ end=+--+

syn region etmlDoctype
      \ start=+<!DOCTYPE+
      \ end=+>+
syn region etmlProcessingInstruction
      \ start=+<?+
      \ end=+?>+
      \ contains=etmlTagName,etmlTagAttribute,etmlTagAttributeValue


let b:current_syntax = 'etml'

hi def link etmlString String

hi def link etmlProcessingInstruction etmlTag
hi def link etmlTag Identifier
hi def link etmlTagEnd Identifier
hi def link etmlTagName Statement
hi def link etmlTagAttribute Type
hi def link etmlTagAttributeValue String

hi def link etmlDoctype Comment
hi def link etmlCommentStart etmlComment
hi def link etmlCommentPart etmlComment
hi def link etmlComment Comment
hi def link etmlCommentError Error


let &cpo = s:keepcpo
unlet s:keepcpo
