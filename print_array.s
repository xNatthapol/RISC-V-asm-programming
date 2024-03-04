.data
A: .word 11, 22, 33, 44, 55
space: .asciiz " "
newline: .asciiz "\n"

.text
main:
    # passing the two arguments to a0 and a1
    la a0, A # a0 = &A
    addi a1, x0, 5 # a1 = 5

    # jump to the print_array procedure
    jal print_array # print_array function caller

    j exit # goto exit

print_array:
    addi sp, sp, -12 # sp = -12
    # save register to the stack
    sw ra, 8(sp) 
    sw s1, 4(sp)
    sw s0, 0(sp)
    addi t0, x0, 0 # i = 0
    
    # move parameters in a0 and a1 to callee-saved registers
    mv s0, a0 # s0 = a0
    mv s1, a1 # s1 = a1
    
loop:
    bge t0, s1, loop_exit # exit loop if i >= size
    slli t1, t0, 2 # i = i * 4
    add t1, s0, t1 # t1 = &A[0] + i*4
    lw t1, 0(t1) # t1 = A[i]

    # printf("%d ", A[i])
    addi a0, x0, 1
    mv a1, t1 # a1 = t1
    ecall # Environmental Calls
    addi a0, x0, 4
    la a1, space
    ecall # Environmental Calls

    addi t0, t0, 1 # i++
    j loop # goto loop

loop_exit:
    addi a0, x0, 4 # a0 = 4; to print_string
    la a1, newline # load address from newline to a1
    ecall # Environmental Calls

    # restore ra and return
    lw ra, 8(sp)
    lw s1, 4(sp)
    lw s0, 0(sp)
    addi sp, sp, 12

    jr ra # goto function caller

exit:
    # Terminate the program
    addi a0, x0, 10 # set a0 to 10
    addi a1, x0, 0
    ecall # Environmental Calls