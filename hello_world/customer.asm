section .data
    kwh db 0
    n times 100 db 0
    insert_name db "Name: ", 10, 0
    insert_kwh db "Kilowatt per hour: ", 10, 0
    printf_string db "ciao: %s", 10,  0
    scanf_string db "%55s", 0
    printf_dec db "costo: %d.%d", 10,  0

section .text
    global _start
    extern scanf
    extern printf

_start:
    push rbp
    mov rbp, rsp
    sub rsp, 8

    ; lea rdi, [scanf_string]
    ; lea rsi, [n]
    ; xor eax, eax
    ; call scanf
    ;
    ; lea rdi, [printf_string]
    ; lea rsi, [n]
    ; xor rax, rax
    ; call printf

    mov rdi, 1115

    call bill

    xor rdx, rdx
    mov rbx, 100
    div rbx
    mov rbx, rdx

    lea rdi, [printf_dec]
    mov rsi, rax
    mov rdx, rbx
    xor rax, rax
    call printf

    mov rax, 60
    mov rdi, 0
    syscall


bill:
    push rbp
    mov rbp, rsp
    sub rsp, 8

    mov rdx, rdi
    cmp rdi, 1000
    jg greater

    mov rax, 2000
    leave
    ret

    greater:
        mov rax, 2000
        sub rdx, 1000
        add rax, rdx

    leave
    ret
