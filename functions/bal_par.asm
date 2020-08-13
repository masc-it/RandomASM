section .data
    str1 db "((()())()())"
    str1_len equ $-str1
    fmt_number db "%d", 10, 0

section .text
    global _start
    extern printf

_start:
    push rbp
    mov rbp, rsp
    sub rsp, 8

    lea rdi, [str1]
    mov rsi, str1_len

    call is_balanced

    lea rdi, [fmt_number]
    mov rsi, rax
    xor rax, rax
    call printf

    mov rax, 60
    mov rdi, 0
    syscall


is_balanced:
    push rbp
    mov rbp, rsp
    sub rsp, 8

    xor rcx, rcx
    xor rdx, rdx
    xor rax, rax ; ah = # open , al = # closed
    lo1:
        mov dl, byte[rdi+rcx]
        cmp dl, '('
        jne check_closed
        inc ah
        jmp next

        check_closed:
            inc al
            cmp ah, al
            jl fin_err ; # open < closed

        next:
            inc rcx
            cmp rcx, rsi
            jl lo1

        mov bl, al
        sub bl, ah

        cmp rbx, 0
        jne fin_err

        mov rax, 1
        leave
        ret

    fin_err:
        mov rax, 0

    leave
    ret
