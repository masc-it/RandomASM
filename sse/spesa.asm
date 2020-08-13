section .data
    scanf_float db "%lf",0
    msg1 db "Inserisci prezzo: ", 10, 0
    fmt_tot db "Tot: %f €", 0
    fmt_string db "%f", 10, 0
    spese1 times 4 dd 0.0
    spese2 times 4 dd 0.0

    lol1 dd 2.2
    lol2 dd 2.3
    siz equ 4

section .bss
    asd1 resd 4

section .text
    global _start
    extern printf
    extern scanf

_start:
    push rbp
    mov rbp, rsp
    sub rsp, 8

    ; populate spese1
    lea rsi, [spese1]
    mov rax, [lol1]
    mov rcx, 0
    lo1:
        mov [rsi+siz*rcx], rax
        inc rcx
        cmp rcx, 4
        jl lo1

    ; populate spese2
    lea rsi, [spese2]
    mov rax, [lol2]
    mov rcx, 0
    lo2:
        mov [rsi+siz*rcx], rax
        inc rcx
        cmp rcx, 4
        jl lo2


    lea r8, [spese1]

    mov rcx, 0
    lo3a:
        cvtps2pd xmm0, [r8+siz*rcx]
        lea rdi, [fmt_string]
        mov rax, 1
        push rcx
        push r8
        call printf
        pop r8
        pop rcx
        inc rcx
        cmp rcx, 4
        jl lo3a


    lea r8, [spese2]

    mov rcx, 0
    lo3b:
        cvtps2pd xmm0, [r8+siz*rcx]
        lea rdi, [fmt_string]
        mov rax, 1
        push rcx
        push r8
        call printf
        pop r8
        pop rcx
        inc rcx
        cmp rcx, 4
        jl lo3b


    movups xmm1, [spese1]
    movups xmm2, [spese2]
    addps xmm1, xmm2
    movups [asd1], xmm1

    lea r8, [asd1]
    mov rcx, 0
    lo3:
        cvtps2pd xmm0, [r8+siz*rcx]
        ; movq xmm0, qword[r8+siz*rcx]
        lea rdi, [fmt_string]
        xor rsi, rsi
        mov rax, 1
        push rcx
        push r8
        call printf
        pop r8
        pop rcx
        inc rcx
        cmp rcx, 4
        jl lo3


    mov rax, 60
    mov rdi, 0
    syscall
