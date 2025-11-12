.text
main:
  addi $sp,$0,-4096
  
loop:
  addi $t0,$0,-1         # All LEDs on (0xFFFFFFFF)
  sw   $t0,-240($0)
  
  add  $t0,$0,$0         # All LEDs off (0x00000000)
  sw   $t0,-240($0)
  
  lui  $t0,0xAAAA        # Alternating pattern
  ori  $t0,$t0,0xAAAA    # 0xAAAAAAAA
  sw   $t0,-240($0)
  
  addi $t0,$0,1          # Walking LED
  sll  $t0,$t0,16        # Shift to middle
  sw   $t0,-240($0)
  
  j    loop