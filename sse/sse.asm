section .data
    v1:	dd 1.1, 2.2, 3.3, 4.4
    v2:	dd 1.1, 2.2, 3.3, 4.4

section .text
    global _start
    global sse0
    
_start:

    call sse0

    mov rax, 60
    mov rdi, 0
    syscall


sse0:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    pxor xmm0, xmm0     ; azzera
    pxor xmm1, xmm1     ; azzera
    movaps xmm0, [v1]   ; move aligned packed singles
    movaps xmm1, [v2]   ; move aligned packed singles
    addps xmm0, xmm1    ; add packed singles, result in xmm0

    leave
    ret
