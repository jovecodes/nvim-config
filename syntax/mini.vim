" Vim indent plugin file
" Language: Minilang
" Maintainer: Maxim Kim <habamax@gmail.com>
" Website: https://github.com/habamax/vim-minilang
" Last Change: 2024-01-15
"
" This file has been manually translated from Vim9 script.

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syntax keyword minilangKeyword using transmute cast distinct opaque where dynamic
syntax keyword minilangKeyword struct enum union const bit_field bit_set
syntax keyword minilangKeyword package fn import export extern
syntax keyword minilangKeyword size_of offset_of type_info_of typeid_of type_of align_of
syntax keyword minilangKeyword return defer
syntax keyword minilangKeyword inline no_inline

syntax keyword minilangConditional if when else do for while switch case continue break
syntax keyword minilangType string cstring bool any f16 f32 f64
syntax keyword minilangType u8 u16 u32 u64 u128 void quaternion
syntax keyword minilangType float uint usize s8 s16 s32 s64 s128 int complex
syntax keyword minilangBool true false
syntax keyword minilangNull null
syntax match minilangUninitialized '\s\+---\(\s\|$\)'

syntax keyword minilangOperator in notin not_in
syntax match minilangOperator "?" display
syntax match minilangOperator "->" display

syntax match minilangTodo "TODO" contained
syntax match minilangTodo "XXX" contained
syntax match minilangTodo "FIXME" contained
syntax match minilangTodo "HACK" contained

" syntax region minilangRawString start=+`+ end=+`+

" r"..." style
syntax region minilangRawString0 start=+r"+ end=+"+ keepend contains=NONE
syntax region minilangRawString1 start=+r&"+ end=+"&+ keepend contains=NONE
syntax region minilangRawString2 start=+r&&"+ end=+"&&+ keepend contains=NONE
syntax region minilangRawString3 start=+r&&&"+ end=+"&&&+ keepend contains=NONE
syntax region minilangRawString4 start=+r&&&&"+ end=+"&&&&+ keepend contains=NONE
highlight link minilangRawString0 String
highlight link minilangRawString1 String
highlight link minilangRawString2 String
highlight link minilangRawString3 String
highlight link minilangRawString4 String

syntax region minilangChar start=+'+ skip=+\\\\\|\\'+ end=+'+
syntax region minilangString start=+"+ skip=+\\\\\|\\'+ end=+"+ contains=minilangEscape
syntax match minilangEscape display contained /\\\([nrt0\\'"]\|x\x\{2}\)/

" syntax match minilangfnedure "\v<\w*>(\s*::\s*fn)@="

syntax match minilangAttribute "@\ze\<\w\+\>" display
syntax region minilangAttribute
      \ matchgroup=minilangAttribute
      \ start="@\ze(" end="\ze)"
      \ transparent oneline

syntax match minilangInteger "\<-\=\d\+\(_\d\+\)*\>" display
syntax match minilangFloat "\<-\=\d\+\(_\d\+\)*\(\.\d\+\(_\d\+\)*\)\=\([eE][+-]\=\d\+\(_\d\+\)*\)\=\>" display
syntax match minilangHex "\<0[xX][0-9A-Fa-f]\+\(_[0-9A-Fa-f]\+\)*\>" display
syntax match minilangDoz "\<0[zZ][0-9a-bA-B]\+\(_[0-9a-bA-B]\+\)*\>" display
syntax match minilangOct "\<0[oO][0-7]\+\(_[0-7]\+\)*\>" display
syntax match minilangBin "\<0[bB][01]\+\(_[01]\+\)*\>" display

syntax match minilangAddressOf "@" display
syntax match minilangDeref "\*" display

syntax match minilangMacro "#\<\w\+\>" display

syntax match minilangTemplate "$\<\w\+\>"

syntax region minilangLineComment start=/\/\// end=/$/  contains=@Spell,minilangTodo
syntax region minilangBlockComment start=/\/\*/ end=/\*\// contains=@Spell,minilangTodo,minilangBlockComment
syn sync ccomment minilangBlockComment

highlight def link minilangKeyword Statement
highlight def link minilangConditional Conditional
highlight def link minilangOperator Operator

highlight def link minilangString String
highlight def link minilangRawString String
highlight def link minilangChar Character
highlight def link minilangEscape Special

highlight def link minilangfnedure Function

highlight def link minilangMacro Macro
highlight def link minilangTemplate Type

highlight def link minilangLineComment Comment
highlight def link minilangBlockComment Comment

highlight def link minilangTodo Todo

highlight def link minilangAttribute Statement
highlight def link minilangType Type
highlight def link minilangBool Boolean
highlight def link minilangNull Constant
highlight def link minilangUninitialized Constant
highlight def link minilangInteger Number
highlight def link minilangFloat Float
highlight def link minilangHex Number
highlight def link minilangOct Number
highlight def link minilangBin Number
highlight def link minilangDoz Number

let b:current_syntax = "minilang"

let &cpo = s:cpo_save
unlet s:cpo_save
