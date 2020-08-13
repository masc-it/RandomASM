#!/bin/sh

cd $1
nasm -f elf64 -o $2.o $2.asm
ld -melf_x86_64 --dynamic-linker=/lib64/ld-linux-x86-64.so.2 -o $2 $2.o -lc -lcurses
./$2
