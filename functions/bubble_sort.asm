section .data
    N db 11
    arr db 10, 9, 8, 7, 6 , 5,4,3,2,1,0

    fmt_number db "%d", 10, 0

section .text
    global _start
    global bubble_sort
    extern printf

_start:
    push rbp
    mov rbp, rsp
    sub rsp, 8

    xor rdi, rdi
    lea rdi, [arr]
    call bubble_sort

    mov r8, rax
    mov rcx, 0

    print:
        lea rdi, [fmt_number]
        movzx rsi, byte[r8+rcx]
        xor rax, rax
        push rcx
        push r8
        call printf
        pop r8
        pop rcx
        inc rcx
        cmp cl, byte[N]
        jl print

    mov rax, 60
    mov rdi, 0
    syscall


bubble_sort:
    push rbp
    mov rbp, rsp
    sub rsp, 8

    ; array is in rdi

    movzx r11, byte[N] ; N
    dec r11

    xor rax, rax ; k
    xor rcx, rcx ; i

    xor rbx, rbx ; arr[i], arr[i+1]
    xor rdx, rdx ; temp

    k:
        cmp rax, r11
        jge k_exit
        i:
            cmp rcx, r11

            jge i_exit

            mov bh, byte[rdi+rcx]
            mov bl, byte[rdi+rcx+1]

            cmp bh, bl
            jle i_inc

            mov dl, bl
            mov bl, bh
            mov bh, dl

            mov [rdi+rcx], bh
            mov [rdi+rcx+1], bl
            i_inc:
                inc rcx
                jmp i
            i_exit:
                xor rcx, rcx
                inc rax
                jmp k
    k_exit:
        mov rax, rdi


    leave
    ret
