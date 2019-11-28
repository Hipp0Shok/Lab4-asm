.586 ;директива использования системы команд процессора Intel.586
 .xmm ;директива использования технологии xmm
 .model flat, stdcall
 option casemap :none
 include \masm32\include\windows.inc
 include \masm32\include\user32.inc
 include \masm32\include\kernel32.inc
 include \masm32\include\debug.inc
 includelib \masm32\lib\debug.lib
 includelib \masm32\lib\user32.lib
 includelib \masm32\lib\kernel32.lib
 .data
vect1 dd 546.2156, 5452.31646, 966.1214544, 44.98, 0.64634, 55462.32, 1346.313464, 5287.21
bcd0 db 4 dup(0)
bcd21 db 4 dup(0)
bcd22 db 4 dup(0)
 .code
start:
    movaps XMM0, vect1
    movaps XMM1, vect1+16
    mulps XMM0, XMM1
    movss bcd0, XMM0
    shufps XMM0, XMM0, 11000110b
    movss bcd21, XMM0
    movss bcd22, XMM0
    mov ecx, 4
    xor ebx, ebx
loop1:
    mov bl, bcd0[ecx-1]
    and bl, 0f0h
    ;mov bl, 79h
    cmp bl, 90h
    jl upDone
    and bcd0[ecx-1], 0fh
upDone:
    mov bl, bcd0[ecx]
    and bl, 0fh
    cmp bl, 09h
    jl downDone
    and bcd0[ecx-1], 0f0h
downDone:
    loop loop1
    invoke ExitProcess, NULL
end start
