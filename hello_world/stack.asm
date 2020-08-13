section .data
    msg: db "Hello world", 10, 0
    len: equ $-msg

    x equ 0
    y equ 8

section .text
    global _start
    ; extern printf

_start:

    ;lea rdi, [msg]
    ;mov rsi, len

    ;call fun2

    mov rdi, 10

    call factorial
    
    mov rax, 60
    mov rdi, 0
    syscall


fun1:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov [rsp+x], rdi
    mov [rsp+y], rsi

    xor rax, rax
    mov rax, [rsp+x]
    add rax, [rsp+y]

    add rsp, 48
    leave
    ret

fun2:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rsp+x], rdi ; string


    mov [rsp+y], rsi ; length

    mov rcx, rsi

    mov rax, 1
    mov rdi, 1
    mov rsi, [rsp+x] ; stringa
    mov rdx, [rsp+y] ; lunghezza
    syscall

    add rsp, 16
    leave
    ret


factorial:
    n equ 8
    push rbp
    mov rbp, rsp
    sub rsp, 16

    cmp rdi, 1
    jg greater

    mov rax, 1
    leave
    ret

    greater:
        mov [rsp+n], rdi
        dec rdi
        call factorial
        mov rdi, [rsp+n]
        imul rax, rdi

        leave
        ret
