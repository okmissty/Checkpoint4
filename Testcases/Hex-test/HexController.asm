.text
.globl main

main:
    # Test basic R-type instruction
    add $t0, $zero, $zero
    
    # Test I-type instruction  
    addi $t1, $zero, 5
    
    # Test load instruction
    lw $t2, 0($zero)
    
    # Test store instruction
    sw $t1, 4($zero)
    
    # Test branch instruction
    beq $t0, $t1, end
    
end:
    # Halt (infinite loop or syscall)
    j end