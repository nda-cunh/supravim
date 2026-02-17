vim9script

if exists("b:current_syntax")
  finish
endif

syn match nasmRegister /\<\%(r\|e\)\?[abcd]x\>/
syn match nasmRegister /\<\%([abcd][lh]\)\>/
syn match nasmRegister /\<\%(r\|e\)\?\%(si\|di\|bp\|sp\)\>/
syn match nasmRegister /\<r\%(8\|9\|10\|11\|12\|13\|14\|15\)\%([dbw]\)\?\>/
syn match nasmNumber /\<\(0x\x\+\|0b[01]\+\|0o[0-7]\+\|\d\+\)\>/

syn match nasmReloc /\.\.\%(plt\|got\|gotoff\|gotpc\)\>/
syn match nasmConst /\<\([A-Z_]\+\)\>/
syn match nasmCallTarget /[a-zA-Z0-9_\.]\+/ contained contains=nasmReloc
syn match nasmJumpTarget /[a-zA-Z0-9_\.]\+/ contained
syn match nasmCallInstr /\<call\>/ nextgroup=nasmCallTarget skipwhite
syn match nasmJumpInst /\<\%(jmp\|je\|jne\|jz\|jnz\|jg\|jge\|jl\|jle\)\>/ nextgroup=nasmJumpTarget skipwhite
syn keyword nasmInstruction mov movq movsd movss movzx movsx movaps movups
syn keyword nasmInstruction add sub mul div cmp ret push pushq pop popq nop leave
syn keyword nasmInstruction lea inc dec interrupt syscall int
syn keyword nasmStorage db dw dd dq resb resw resd resq
syn keyword nasmOperator wrt rel abs rel rel8 rel16 rel32
syn keyword nasmSection section segment global extern macro endmacro
syn match nasmDirective /^\s*\%(\.\|%\)\w\+/
syn region nasmString start=+"+ skip=+\\\\\|\\"+ end=+"+
syn region nasmString start=+'+ skip=+\\\\\|\\'+ end=+'+
syn match nasmLabel /^\s*[@\.a-zA-Z_][a-zA-Z0-9_\.]*:/
syn match nasmComment /;.*$/
syn match nasmOperator /[-+*/%&|^!<>~,]/
syn keyword nasmType byte word dword qword tword oword yword zword ptr

hi link nasmInstruction Statement
hi link nasmCallInstr Statement
hi link nasmJumpInst Conditional
hi link nasmCallTarget Function
hi link nasmJumpTarget Label
hi link nasmRegister Special
hi link nasmDirective PreProc
hi link nasmSection Type
hi link nasmStorage StorageClass
hi link nasmNumber Number
hi link nasmString String
hi link nasmLabel Label
hi link nasmComment Comment
hi link nasmOperator Operator
hi link nasmReloc Special
hi link nasmConst Constant
hi link nasmType Type

b:current_syntax = "nasm"
