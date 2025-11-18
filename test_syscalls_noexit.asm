# test_syscalls_noexit.asm - Exercises syscalls without calling exit
# Assemble with: ./assemble kernel.asm test_syscalls_noexit.asm static.bin inst.bin

.text
main:
    # Print "Hi\n"
    addi $a0, $zero, 72       # 'H'
    addi $v0, $zero, 11
    syscall
    addi $a0, $zero, 105      # 'i'
    syscall
    addi $a0, $zero, 10       # '\n'
    syscall

    # Print integer 123 and newline
    addi $a0, $zero, 123
    addi $v0, $zero, 1
    syscall
    addi $a0, $zero, 10
    addi $v0, $zero, 11
    syscall

    # Print negative integer -456 and newline
    addi $a0, $zero, -456
    addi $v0, $zero, 1
    syscall
    addi $a0, $zero, 10
    addi $v0, $zero, 11
    syscall

    # Allocate 12 bytes on heap (syscall 9)
    addi $a0, $zero, 12
    addi $v0, $zero, 9
    syscall
    add $t0, $v0, $zero       # Save pointer to $t0

    # Store two words into allocated memory
    addi $t1, $zero, 42
    sw $t1, 0($t0)
    addi $t1, $zero, 100
    sw $t1, 4($t0)

    # Read one character (syscall 12) and echo it back
    addi $v0, $zero, 12
    syscall
    add $a0, $v0, $zero
    addi $v0, $zero, 11
    syscall

    # Read an integer (syscall 5), then print it back
    addi $v0, $zero, 5
    syscall
    add $a0, $v0, $zero
    addi $v0, $zero, 1
    syscall
    addi $a0, $zero, 10
    addi $v0, $zero, 11
    syscall

    # Instead of calling syscall 10 (kernel exit which loops forever),
    # just loop here in user space so the kernel is not re-entered.
done:
    j done
