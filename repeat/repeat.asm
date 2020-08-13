section .bss
    arr1 resb 10
    arr2 resb 10

section .text
    global _start

_start:

    populate1:
        mov rcx, 0
        mov rsi, arr1
        lo:
            mov [arr1], rcx
            ; debug
            mov rdx, [arr1]
            inc rsi
            mov [arr1], rsi

            inc rcx
            cmp rcx, 10
            jl lo

        populate2:
            mov rcx, 0
            mov rsi, arr2
            lo2:
                mov [arr2], rcx
                ; debug
                mov rdx, [arr2]
                inc rsi
                mov [arr2], rsi

                inc rcx
                cmp rcx, 10
                jl lo2

    mov rsi, arr1
    add rsi, 3
    mov [arr1], rsi
    mov [arr1], byte 10

    mov rsi, arr2
    add rsi, 3
    mov [arr2], rsi
    mov [arr2], byte 11

    ; check time
    cld
    MOV   CX, 10
    MOV   RSI, arr1
    MOV   RDI, arr2
    check:
    REPZ  CMPSB
    jne mis
    jmp check
mis:
    dec RSI
    dec RDI
        mov rax, 1
        mov rdi, 1
        mov rsi, 100
        mov rdx, 1
        syscall

    mov rax, 60
    mov rdi, 0
    syscall
