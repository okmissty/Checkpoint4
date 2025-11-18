# test_simple_syscall.asm
# Simplest possible test - just call exit syscall

.text
    # Syscall 10 - Exit (should loop forever in Syscall10)
    addi $v0, $zero, 10       # Set syscall code to 10
    syscall                    # Call kernel
    # Should never reach here - exit loops forever