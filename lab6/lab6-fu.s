.equ	switches, 0x00003030
.equ	leds, 0x00003020
.equ	hexa, 0x00003010
.equ	hexb, 0x00003000
.global _start

__default_stacksize=1024

_start:
	#Start up Sequence
	movia sp, STACK		#Give stack initial value


main:

    subi sp, sp, 12		#Allocate stack
	stw ra, 0(sp)		#save return address
	#r8 = val
	#r9 = res
	#Prologue
	#no function parameters

	call read		#calls read function

	#Epilogue
	#restore caller regs
	mov r8, r2		#load switches into r8 (value) from r2(return register)

	#Prologue
	mov r4, r8		#put function parameter in r4 register
	#save callee save reg
	stw r8, 4(sp)		#store r8 onto stack

	call fact		#call

	#epilogue
	#restore caller save regs
	ldw r8, 4(sp)		#restore r8

	mov r9,	r2		#get return value from r2 into r9/res

	#Prologue
	mov r4, r9		#?#store function parameter (res) into correct register r4
	#save callee save reg
	stw r8, 4(sp)       #save callee save reg r8=val
	stw r9, 8(sp)       #save callee save reg r9=res

	call print

	#Epilogue
	ldw r9, 8(sp)
	ldw r8, 4(sp)
	#no need to retrive value from r2

	#Clean up sequence
	ldw ra, 0(sp)		#restore ra
	addi sp, sp, 12		#deallocate stack

	br main			    #either loop back to main or end


fact:

	subi sp, sp, 8		#allocate stack
	stw ra, 0(sp)		#save return address

	bne r4, r0, else	#condition if(r4 != r0) go to else
	movia r2, 1		    #move 1 into r11 to return 1
	ldw ra, 0(sp)       #restore return address
	addi sp, sp, 8      #deallocate
	ret

else:

	mov r11, r4         #move r4(val) into r11
	stw r11, 4(sp)      #store r11
	subi r4, r4, 1      #decrement

	call fact		    #calls again

	ldw r11, 4(sp)		#load r11

	mul r2, r2, r11	    #r4 * r11 * next r11 * next r11 etc
	ldw ra, 0(sp)       #reload return address
	addi sp, sp, 8
	ret 			    #return out of called recursive function




read:


	movia r23, switches	#move switches address to r2
	ldbio r2, 0(r23)	#load PIO switches (r23) into r2 return register

	#clean up
	#nothing
	ret


print:
	#Startup Sequence
	#allocate storage for stack frame
	#no need to save return address as no call
	#save callee save reg that use in body


	movia r18, lut		#address of lut to r18
	movia r19, hexa		#move hexa address to r19
	movia r20, hexb		#move hexb address to r20

    #load value into registers

	mov r16, r4		#load function parameter (r4/res) into a caller register
	mov r17, r16		#second register for second SSD

	andi r16, r16, (0x000f) 	#r16 address is low 4 digits

	srai r17, r17, 4		#shifts r17 4 bits over XY00->00XY
	andi r17, r17, (0x000f)	#r17 address is now low 4 digits (actually high 4 shifted right to low 4)

	slli r16, r16, 2		#shift 2 = multiply by 4 (size)
	slli r17, r17, 2		#shift 2 = multiply by 4 (size)

	add r16, r16, r18		#add the offset to address of lut
	add r17, r17, r18		#^

	ldw r21, 0(r16)         #load into random register
	ldw r22, 0(r17)

	stbio r21, 0(r19)	#load r16 to hexa
	stbio r22, 0(r20)	#load r17 to hexb

	#Clean up
	#never saved return address cant load
	#deallocate storage for stack frame
	ret			        #return



	.data
	lut:
	.word (0x40)	#0 switch value
	.word (0x79)	#1 switch value
	.word (0x24)	#2 switch value
	.word (0x30)	#3
	.word (0x19)	#4
	.word (0x12)	#5
	.word (0x02)	#6
	.word (0x78)	#7
	.word (0x00)	#8
	.word (0x18)	#9
	.word (0x08)	#a
	.word (0x03)	#b
	.word (0x46)	#c
	.word (0x21)	#d
	.word (0x06)	#e
	.word (0x0e)	#f
	.skip __default_stacksize
	STACK:
	.end
