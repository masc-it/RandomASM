section .text
    global _start

_start:
    mov rax, 0x12345678
    shr rax,  24 ; I want bits 8-15
    and rax, 0xff ; rax now holds Ox56
    mov rax, 0x12345678 ;I want to replace bits 8-15
    mov rdx, 0xaa ;rdx holds replacement field
    mov rbx, 0xff ;I need an 8 bit mask
    shl rbx, 8 ;Shift mask to align @ bit 8
    not rbx ;rbx is the inverted mask
    and rax, rbx ; Now bits 8- 15 are all 0
    shl rdx, 8 ;shift the new bits to align
    or rax, rdx ;rax now has Ox1234aa78

    mov rax, 60
    mov rdi, 0
    syscall
