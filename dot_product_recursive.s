.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
dotproduct: .string "The dot product is: "
newline: .string "\n"

.text
main:
    la a0, a # load address of a to a0
    la a1, b # load address of b to a1
    li a2, 5 # load size of a and b to a2

    jal dot_product_recursive # dot_product_recursive function caller

    mv t5, a0 # move the result to t5

    # use print_string to print a string dotproduct
    addi a0, x0, 4 # load 4 to a0
    la a1, dotproduct # load address of dotproduct to a1
    ecall # Environment call

    # print_int; result
    addi a0, x0, 1 # load 1 to a0
    mv a1, t5 # move the result to a1
    ecall # Environment call
    
    # use print_string to print a newline
    addi a0, x0, 4 # load 4 to a0
    la a1, newline # load address of newline to a1
    ecall # Environment call
    
    # terminate the program
    addi a0, x0, 10 # load 10 to a0
    ecall # Environment call

dot_product_recursive:
    # base case
    addi t0, x0, 1 # t0 = 1
    beq a2, t0, exit_base_case # if size == 1, then exit_base_case

    # recursive case
    addi sp, sp, -4 # sp = sp + (-4)   
    sw ra, 0(sp) # storing the ra value on to the stack

    # dot_product_recursive(a, b, size)
    addi sp, sp, -4 # sp = sp + (-4)
    sw a0, 0(sp) # storing the a0 value on to the stack

    addi sp, sp, -4 # sp = sp + (-4)
    sw a1, 0(sp) # storing the a1 value on to the stack

    addi a0, a0, 4 # a0 = a0 + 4
    addi a1, a1, 4 # a1 = a1 + 4
    addi a2, a2, -1 # a2 = a2 - 1
    
    jal dot_product_recursive # dot_product_recursive function caller

    # restoring the value from the stack after the recursive call
    lw t1, 0(sp) # loading the t1 value from the stack
    lw t1, 0(t1) # loading the t1 value from the address of t1
    addi sp, sp, 4 # sp = sp + 4

    lw t2, 0(sp) # loading the t1 value from the stack
    lw t2, 0(t2) # loading the t1 value from the address of t2
    addi sp, sp, 4 # sp = sp + 4

    # multiplying the a0 and a1 values
    mul t0, t1, t2 # t0 = t1 * t2
    add a0, a0, t0 # a0 = a0 + t0

    lw ra, 0(sp) # loading the ra value from the stack
    addi sp, sp, 4 # sp = sp + 4
    jr ra # return to the caller

exit_base_case:
    lw t3, 0(a0) # loading the t3 value from the address of a0
    lw t4, 0(a1) # loading the t4 value from the address of a1

    mul a0, t3, t4 # a0 = t3 * t4

    jr ra # return to the caller