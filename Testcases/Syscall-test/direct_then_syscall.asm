# direct_then_syscall.asm
# First performs a direct MMIO write to the terminal address (like `kernel_direct_write.asm`),
# then calls the syscall-print-char (11) to verify both routes toggle the terminal write.

.text
main:
    # Build terminal address in $t0 (0x03FFFF00)
    lui  $t0, 0x03FF
    ori  $t0, $t0, 0xF000
    addi $t0, $t0, 0xF00

    # Direct write 'D'
    addi $t1, $zero, 68      # 'D'
    sw   $t1, 0($t0)

    # Use syscall 11 to print 'S'
    addi $a0, $zero, 83      # 'S'
    addi $v0, $zero, 11
    syscall

    # Print newline via syscall
    addi $a0, $zero, 10
    addi $v0, $zero, 11
    syscall

    # Loop in user space
hang:
    j hang
