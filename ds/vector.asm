section .data
    actual_size dq 128 ; 16 qwords as beginning
    element_size EQU 8
    chunk EQU 128
    threshold EQU 24

    current_offset dq 0
    size dq 0

    printf_1 db "%c", 10,0
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

    ; alloco memoria iniziale
    call alloc_vector
    mov [rsp+.vector_addr], rax

    ; PRIMO ELEMENTO

    ; controllo disponibilità memoria
    mov rdi, [rsp+.vector_addr]
    call check_size

    ; aggiungo elemento
    mov rdi, [rsp+.vector_addr]
    xor rax, rax
    mov al, 65
    mov rsi, rax
    call add_element

    ; stampo
    lea rdi, [printf_1]
    mov rdx, [rsp+.vector_addr]
    mov rsi, qword[rdx]
    xor rax, rax
    call printf


    ; SECONDO ELEMENTO
    mov rdi, [rsp+.vector_addr]
    call check_size

    mov rdi, [rsp+.vector_addr]
    xor rax, rax
    mov al, 66
    mov rsi, rax
    call add_element

    ; todo sposta check_size in add_element

    lea rdi, [printf_1]
    mov rdx, [rsp+.vector_addr]
    add rdx, element_size
    mov rsi, qword[rdx]
    xor rax, rax
    call printf



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


check_size:

    push rbp
    mov rbp, rsp
    sub rsp, 8

    ; copio la dimensione attuale
    mov r8, [size]

    ; calcolo offset
    mov rax, r8
    mov rbx, element_size
    mul rbx

    mov rdx, rax

    mov rax, rdi ; return
    mov [current_offset], rdx
    ; debug

    ;xor rax, rax
    ;mov al, 125

    ; controllo se ci sono almeno 24 byte (3 qword) liberi
    mov r9, [actual_size]
    mov rbx, threshold
    sub r9, rdx ; byte rimanenti
    cmp r9, rbx
    jg fin ; non reallocare se > threshold

    call realloc_vector
    fin:
    leave
    ret


add_element:
    ; rdi = indirizzo
    ; rsi = elemento da inserire
    push rbp
    mov rbp, rsp
    sub rsp, 8
    ;mov rdi, [rsp+.vector_addr]
    mov rax, [current_offset]
    add rdi, rax
    mov [rdi], qword rsi

    ; size = size + 1
    mov r8, [size]
    inc r8
    mov [size], r8

    leave
    ret
