section .data
    text db "Hello world",10,  0
    text2 db "weeeeeela mother fuckaaaa",10,  0

section .text
    global _start

_start:
    ;mov rax, 1
    ;mov rdi, 1
    ;mov rsi, text
    ;mov rdx, 14
    ; syscall

    mov rdi, text
    call printString

    mov rdi, text2
    call printString

    mov rax, 60
    mov rdi, 0
    syscall

_strlen:
    mov r8, rdi
    mov rbx, 0
    mov rcx, 0
check:
    mov cl, [r8]
    cmp cl, 0
    je fin
    inc r8
    inc rbx
    jmp check

fin:
    mov rax, rbx

    ret

printString:

    push rdi ; stringa
    call _strlen
    push rax ; lunghezza

    mov rax, 1
    mov rdi, 1
    pop rdx ; lunghezza
    pop rsi ; stringa

    syscall

    ret


printNumber:
