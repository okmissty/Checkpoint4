# X:-176 (0x3FFFF50), Y:-172 (0x3FFFF54)
.text
main:
    addi $sp,$0,-4096

loop:
    lw   $t0,-176($zero)      # read X
    andi $t0,$t0,0xF          # keep low 4 bits

    lw   $t1,-172($zero)      # read Y
    andi $t1,$t1,0xF          # keep low 4 bits

    add  $s0,$s0,$t0          # s0 += X
    add  $s1,$s1,$t1          # s1 += Y
    j    loop
