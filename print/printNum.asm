section .bss
    digitSpace resb 100
    digitSpacePos resb 8
    num resb 100

section .data
    text db "Hello, World!",10,0

section .text
    global _start

_start:

    mov rax, 2560000
    ;;call _printRAX
    call printNum

    mov rax, 60
    mov rdi, 0
    syscall


printNum:
    mov rcx, num
    mov rbx, 10
    mov [rcx], rbx
    inc rcx

_num:
    mov rdx, 0
    mov rbx, 10
    div rbx

    add rdx, 48

    mov [rcx], rdx
    inc rcx

    cmp rax, 0
    je printReverse

    jmp _num

printReverse:
    push rcx
lol:

    mov rax, 1
    mov rdi, 1
    mov rsi, rcx
    mov rdx, 1
    syscall

    pop rcx
    dec rcx
    push rcx

    cmp rcx, num
    jge lol
    pop rcx
    ret
