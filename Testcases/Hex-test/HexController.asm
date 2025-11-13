.text
.globl main

main:
    # Load the hex display address into a register
    # Address: 0x0FFFCC0 (which is 0x3FFFF30 >> 2 in word addressing)
    lui $t0, 0x0FFF           # Load upper 16 bits: 0x0FFF0000
    ori $t0, $t0, 0xCC0       # OR in lower 16 bits: 0x0FFFCC0
    
    # Load value to display (example: 0x12345678)
    lui $t1, 0x1234           # Load upper: 0x12340000
    ori $t1, $t1, 0x5678      # OR in lower: 0x12345678
    
    # Store to hex display address - this triggers write enable
    sw $t1, 0($t0)            # Write $t1 to address in $t0
    
end:
    # Halt (infinite loop)
    j end