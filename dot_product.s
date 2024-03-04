.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
dotproduct: .string "The dot product is: "
newline: .string "\n"

.text
main:
    # Registers x0 to x4 and x10 to x17 not to use;
    # Registers x5 to x9 and x18 to x31 can use;

    addi x5, x0, 5 # let x5 be size and set it to 5

    addi x6, x0, 0 # let x6 be i and set it to 0
    addi x7, x0, 0 # let x7 be sop and set it to 0

    la x8, a # load address of a to x8
    la x9, b # load address of b to x9

loop:
    bge x6, x5, exit # check if i >= size, goto exit
    slli x18, x6, 2 # set x18 to i*4

    add x19, x18, x8 # add i*4 to the base address of a and put it to x19
    lw x20, 0(x19) # x20 = &a[i]

    add x21, x18, x9 # add i*4 to the base address of a and put it to x21
    lw x23, 0(x21) # x23 = &b[i]

    mul x20, x20, x23 # a[i] = a[i] + b[i]
    add x7, x7, x20 # sop = sop + a[i]; a[i] from a[i] * b[i]

    addi x6, x6, 1 # i++
    j loop # goto loop

exit:
    # use print_string to print a string dotproduct
    addi a0, x0, 4
    la a1, dotproduct
    ecall

    # print_int; sop
    addi a0, x0, 1
    add a1, x0, x7
    ecall
    
    # use print_string to print a newline
    addi a0, x0, 4
    la a1, newline
    ecall
    
    # terminate the program
    addi a0, x0, 10
    ecall