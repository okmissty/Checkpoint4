# kernel_direct_write.asm - minimal test kernel
# Writes a single character 'H' (ASCII 0x48) to terminal MMIO at 0x03FFFF00
# Assembled alone: ./assemble kernel_direct_write.asm static.bin inst.bin

    .text 0x00000000

start:
    # Build terminal address in $t0
    lui  $t0, 0x03FF
    ori  $t0, $t0, 0xF000    # $t0 = 0x03FFF000 (kernel data base)
    # Terminal is at 0x03FFFF00 -> set $t0 = 0x03FFFF00
    addi $t0, $t0, 0xF00     # 0x03FFF000 + 0xF00 = 0x03FFFF00

    # Put ASCII 'H' into $t1 and write
    addi $t1, $zero, 72      # 'H'
    sw   $t1, 0($t0)

    # Small delay loop so you can observe the write
hang:
    j hang
