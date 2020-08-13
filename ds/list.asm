section .data

    scanf_1 db "%c", 0
    printf_1 db "%c", 0
    printf_2 db "%c",10, 0

    vector_size db 0
    num_elems db 0

    struc node
        next_node resq 1
        value resq 1
    endstruc

section .bss
    ch_to_read resq 1

    vector resq 1


section .text
    global _start
    extern scanf
    extern printf
    extern malloc

_start:
.list equ 0
    push rbp
    mov rbp, rsp
    sub rsp, 64

     xor rbx, rbx
     call create
     mov [rsp+rbx], rax

lo1:

    lea rdi, [scanf_1]
    lea rsi, [ch_to_read]
    xor rax, rax
    push rbx
    call scanf

    mov rax, [ch_to_read]
    cmp rax, '.'
    pop rbx
    je done

    mov rdi, [rsp+rbx]
    mov rsi, [ch_to_read]

    call insert

    mov [rsp+rbx], rax
    add rbx, 8
    jmp lo1

    done:

        xor rcx, rcx
        mov rcx, 0
    print:
        lea rdi, [printf_1]
        mov rsi, [rsp+_start.list+rcx]
        add rsi, 8
        mov rsi, [rsi]
        xor rax, rax
        push rcx
        call printf

        pop rcx
        add rcx, 8
        cmp rcx, rbx
        jl print


    ; vector.at(i)
    mov rdi, rsp
    mov rsi, 0
    call vec_at


    mov rax, 60
    mov rdi, 0
    syscall

create:
    xor rax, rax
    ret
insert:
.list equ 0
.val equ 8
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov [rsp+.list], rdi
    mov [rsp+.val], rsi

    mov rdi, node_size
    call malloc

    mov r8, [rsp+.list]
    mov [rax+next_node], r8

    mov r9, [rsp+.val]
    mov [rax+value], r9


    movzx rdx, byte[vector_size]
    add rdx, 16

    mov [vector_size], dl

    movzx rdx, byte[num_elems]
    add rdx, 1

    mov [num_elems], dl

    leave
    ret


vec_at:
    push rbp
    mov rbp, rsp
    sub rsp, 8
    mov r8, rdi
    mov r9, rsi

    lea rdi, [printf_2]
    mov rsi, [r8+_start.list+8*r9]
    add rsi, 8
    mov rsi, [rsi]
    xor rax, rax
    call printf

    leave
    ret
