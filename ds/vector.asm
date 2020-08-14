section .data
    actual_size dq 128 ; 16 qwords as beginning
    element_size EQU 8
    chunk EQU 128
    threshold EQU 24

    size dq 0

    printf_1 db "%d", 10,0
section .bss

section .text
    global _start
    extern malloc
    extern realloc
    extern printf
_start:
.vector_addr EQU 0

    push rbp
    mov rbp, rsp
    sub rsp, 16

    call alloc_vector

    mov [rsp+.vector_addr], rax

    ; copio la dimensione attuale
    mov r8, [size]

    ; calcolo offset
    mov rax, r8
    mov rbx, element_size
    mul rbx

    mov rdx, rax

    ; debug

    ;xor rax, rax
    ;mov al, 125

    ; controllo se ci sono almeno 24 byte (3 qword) liberi
    mov r9, [actual_size]
    mov rbx, threshold
    sub r9, rdx ; byte rimanenti
    cmp r9, rbx
    jg .continue ; non reallocare se > threshold
    mov rdi, [rsp+.vector_addr]
    push r8
    push rdx

    call realloc_vector

    pop rdx
    pop r8


     mov [rsp+.vector_addr], rax



      .continue:

    ; rdx conterrà l'offset


    ; carico elemento da inserire
    xor rax, rax
    mov al, 65

    mov rdi, [rsp+.vector_addr]
    add rdi, rdx
    mov [rdi], qword rax

    ; size = size + 1
    inc r8
    mov [size], r8


    ; 2 elemento
    mov r8, [size]
    ; calcolo offset
    mov rax, r8
    mov rbx, element_size
    mul rbx

    ; rdx conterrà l'offset
    mov rdx, rax
    
    ; carico elemento da inserire
    xor rax, rax
    mov al, 66

    mov rdi, [rsp+.vector_addr]
    add rdi, rdx
    mov [rdi], qword rax


    ; size = size + 1
    inc r8
    mov [size], r8





    mov rax, 60
    mov rdi, 0
    syscall

alloc_vector:
    push rbp
    mov rbp, rsp
    sub rsp, 8

    mov rdi, qword[actual_size]
    call malloc

    leave
    ret


realloc_vector:
    push rbp
    mov rbp, rsp
    sub rsp, 8

    mov rsi, chunk
    xor rdx, rdx
    mov rdx, [actual_size]
    add rsi, rdx
    mov [actual_size], rsi
    call realloc

    leave
    ret
