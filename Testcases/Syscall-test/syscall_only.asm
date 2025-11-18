# syscall_only.asm
# Exercises syscalls without blocking: print chars, print integers,
# heap allocate, store/load, then loop in user space.

.text
main:
    # Build terminal MMIO address in $t2 (0x03FFFF00)
    lui  $t2, 0x03FF
    ori  $t2, $t2, 0xF000
    addi $t2, $t2, 0xF00

    # Print "OK\n" via direct MMIO
    addi $t3, $zero, 79       # 'O'
    sw   $t3, 0($t2)
    addi $t3, $zero, 75       # 'K'
    sw   $t3, 0($t2)
    addi $t3, $zero, 10       # '\n'
    sw   $t3, 0($t2)

    # Print integer 2025 and newline
    addi $a0, $zero, 2025
    addi $v0, $zero, 1
    syscall
    # newline via direct MMIO
    addi $t3, $zero, 10
    sw   $t3, 0($t2)

    # Allocate 8 bytes on heap
    addi $a0, $zero, 8
    addi $v0, $zero, 9
    syscall
    add $t0, $v0, $zero

    # Store values and load them back
    addi $t1, $zero, 123
    sw $t1, 0($t0)
    addi $t1, $zero, 456
    sw $t1, 4($t0)

    lw $a0, 0($t0)
    addi $v0, $zero, 1
    syscall
    # space via direct MMIO
    addi $t3, $zero, 32
    sw   $t3, 0($t2)
    lw $a0, 4($t0)
    addi $v0, $zero, 1
    syscall
    # newline via direct MMIO
    addi $t3, $zero, 10
    sw   $t3, 0($t2)

    # Done: loop in user space to avoid invoking syscall 10
done:
    j done
