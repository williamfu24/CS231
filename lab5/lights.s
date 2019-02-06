.equ	switches, 0x00002030
.equ	leds, 0x00002020
.equ    hexa, 0x00002010
.equ    hexb, 0x00002000
.global _start

_start:
        movia r2, switches #move switches address to r2
        movia r3, leds     #move leds address to r3
        movia r9, hexa      #move hexa address to r9
        movia r10, hexb      #move hexb address to r10


LOOP:   ldbio r4, 0(r2)    #load switches value into r4
        ldbio r5, 0(r2)     #load swiches value into r5
        stbio r4, 0(r3)    #store value of r2 (switches) into leds
        movia r6, lut       #address of lut in r6

        andi r4, r4, (0x000f)     #splits the switches into 2 different 4 bit values

        srai r5,r5, 4               #shifts r5 4 bits over 0x XY00 -> 0x00XY
        andi r5, r5, (0x000f)     #first for bits 0-3, second for bits 4-7

        slli r4, r4, 2          #shift 2 = multiply by 4 (size)
        slli r5, r5, 2          #shift 2 = multiply by 4 (size)

        add r4, r4, r6      #adds the offset to the address of lut
        add r5, r5, r6      #adds the offset to the address of lut

        ldw r7, 0(r4)     #load r4 to random register
        ldw r8, 0(r5)     #load r5 to random register

        stbio r7, 0(r9)    #store value of r4 (in r7) into hexa
        stbio r8, 0(r10)    #store value of r5 (in r8) into hexb
        br LOOP             #loop to beginning

        .data
        lut:                #lookup table array
        .word (0x40)        #0 switch value
        .word (0x79)        #1 switch value
        .word (0x24)        #2 switch value
        .word (0x30)        #3
        .word (0x19)        #4
        .word (0x12)        #5
        .word (0x02)        #6
        .word (0x78)        #7
        .word (0x00)        #8
        .word (0x18)        #9
        .word (0x08)        #a
        .word (0x03)        #b
        .word (0x46)        #c
        .word (0x21)        #d
        .word (0x06)        #e
        .word (0x0e)        #f
.end
