# file hello.s
        .data
msg:    .ascii "Hello, World!\n"
        len = . - msg

        .text
        .globl __start

__start:
        li $v0, 4004    # __NR_write == 4004
        li $a0, 1       # argument: STDOUT_FILENO
        la $a1, msg     # argument: message to write
        li $a2, len     # argument: size of message
        syscall

        li $v0, 4001    # __NR_exit == 4001
        li $a0, 0       # argument: EXIT_SUCCESS
        syscall


