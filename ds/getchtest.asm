section .data
    tmp db 0
    fmt_1 db "%d", 0
    printf_1 db "%c", 10, 0

section .bss
    ch_to_read resb 1

section .text
    global _start
    extern scanf
    extern printf
    extern getch
    extern printw
    extern initscr
    extern endwin

_start:

    push rbp
    mov rbp, rsp
    sub rsp, 8

    ; get user input
    ; lea rdi, [fmt_1]
    ; lea rsi, [tmp]
    ; xor rax, rax
    ; call scanf

    call initscr
    call getch
    mov r8, rax

    ; get user input
    lea rdi, [printf_1]
    mov rsi, r8
    xor rax, rax
    call printw

    call getch
    call endwin

    mov rax, 60
    mov rdi, 0
    syscall
