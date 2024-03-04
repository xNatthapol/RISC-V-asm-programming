.data
newline: .asciiz "\n"

.text
main:
    li a0, 110 # a = 110; set a0 to be arguments 1
    li a1, 50 # b = 50; set a1 to be arguments 2
    jal mult # mult function caller

    mv a1, a0 # a1 = a0
    li a0, 1 # a0 = 1
    ecall # Environment call

    # use print_string to print a newline
    addi a0, x0, 4
    la a1, newline
    ecall

    addi a0, x0, 10 # set a0 to be 10 for termination
    ecall # Environment call

mult:
    # base case
    addi t0, x0, 1 # t0 = 1
    beq a1, t0, exit_base_case # if (b == 1) then goto exit_base_case
    
    # recursive case
    addi sp, sp, -4 # sp = sp + (-4)   
    sw ra, 0(sp) # storing the ra value on to the stack

    # mult(a, b-1)
    addi sp, sp, -4 # sp = sp + (-4)
    sw a0, 0(sp) # storing the a0 value on to the stack
    addi a1, a1, -1 # b = b - 1
    jal mult # mult function caller for recursive call

    # a + mult(a, b-1)
    mv t1, a0 # t1 = a0

    # restoring the a0 value from the stack before the recursive call
    lw a0, 0(sp) # loading the a0 value from the stack
    addi sp, sp, 4 # sp = sp + 4
    add a0, a0, t1 # a = a + t1

    lw ra, 0(sp) # loading the ra value from the stack
    addi sp, sp, 4 # sp = sp + 4
    jr ra # return to the caller

exit_base_case:
    jr ra # return to the caller