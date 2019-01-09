# BAEJ
BAEJ is a Reduced Instruction Set Computer Architecture which implements a load store architecture

## Registers

|Registers | Address | Use |
| --- | --- | --- |
|.f0 - .f15|0-15|General purpose 'function registers' where data is not lost after a function call|
|.t0 - .t28|16-44|General purpose 'temporary registers' where data may be overridden during a function call|
|.a0 - .a5 |45-50|Argument registers for function calls|
|.m0 - .m5 |51-56|Accumulator register on which default mathematical operations are committed|
|.cr       |57|Compiler register|
|.pc       |58|Program counter register|
|.v0 - .v1 |59-60|Return value register from a function call|
|.ra       |61|Return address register|
|.sp       |62|Stack pointer register|
|.z0       |63|Register always holding the value 0|

### Function Registers
Function registers are magic! You are able to use them (.f0 - .f15) without worry of loosing the data after a function call. The best part? You don't even need to back them up to a stack... or anywhere! Thanks to some nifty magic.
**How does the magic work?** The 16 function registers available to you anywhere are actually part of a larger register file consisting of 128 registers. To address all 128 of these registers we have designed a 3 bit register that is called the function call counter (FCC). The FCC stores the count of how many function calls have been made without returning. By using the following formula we can get the next 16 registers in the larger file.

``` target = (FCC * 16) + register ```

For example, if we have made only one function call, FCC would be 1. If we wanted to address our third function register (.f2) we would take  ``` 1 * 16 + 2 ``` to get 18. This means we would be addressing the 18th register in the larger file by using .f2 in our function. This makes sense because registers 0 - 15 would be owned by the place from where our function would be called, thus the 18th register is the third one available to us. If more than 7 function calls are made (the largest value the FCC can hold) then what?

>**Options**
>* Use special memory unit for both memory and backing up registers (Hard but extra credit)
>* Increase FCC to 12 bits and limit to 4096 function calls (easy)
>* Use a dedicated memory unit to backup entire register file (medium possibly extra credit) 128 bit words

## Machine Code Formats
**I**          |<sup>15</sup> OPCODE <sup>12</sup>|<sup>11</sup>    RS    <sup>6</sup>|<sup>5</sup>    RD    <sup>0</sup>|	(1<sup>st</sup> word)
​           |<sup>15</sup>                  IMMEDIATE                   <sup>0</sup>|	(2<sup>nd</sup> word)

>I type instructions use the format above. They are multi-word instructions with the first word consisting of a 4 bit op code followed by two 6 bit register addresses. The second word will be the 16 bit immediate value used in the instruction.

**G**        |<sup>15</sup> OPCODE <sup>12</sup>|<sup>11</sup>    RS    <sup>6</sup>|<sup>5</sup>    RD    <sup>0</sup>|	(1<sup>st</sup> word)

> G type instructions use the same format as I type as described above. They do not, however, have an immediate and only have one word in their machine code format.

## Instructions

|Instruction|Type|OP|Usage|Description|Rtl|
|-----------|----|--|-----|-----------|---|
|```lda```|I Type|0000|```lda .rs[index] .rd```|Loads a value from memory to rd|```rd=Mem[rs+index]```|
|```ldi```|I Type|0001|```ldi .rd immediate```|Loads an immediate to rd|```rd=immediate```|
|```str```|I Type|0010|```str .rs .rd[index]```|Stores value in rs to memory|```Mem[rd+index]=rs```|
|```bop```|I Type|0011|```bop immediate```|Changes pc to immediate|```pc=immediate```|
|```cal```|I Type|0100|```cal immediate```|Changes pc to immediate and sets a return address|```ra=pc+4```<br>```pc=immediate```|
|```beq```|I Type|0101|```beq .rs .rd immediate```|Changes pc to immediate if rs and rd are equal|```if rs==rd```<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;```pc=immediate;```|
|```bne```|I Type|0110|```bne .rs .rd immediate```|Changes pc to immediate if rs and rd aren't equal|```if rs!=rd```<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;```pc=immediate;```|
|```sft```|I Type|0111|```sft .rs .rd immediate```|Shifts value in rs to rd by immediate. Positive shifts left, negative shifts right|```rd=rs<<immediate```|
|```cop```|G Type|1000|```cop .rs .rd```|Copies the value of rs to rd while retaining the original value of rs|```rd=rs```|
|```mov```|G Type|1001|```mov .rs .rd```|Copies the value of rs to rd and places a value of 0 into rs|```rd=rs```<br>```rs=0```|
|```slt```|G Type|1010|```slt .rs .rd```|Sets cr to a value other than 0 if rs is less than rd|```t0=rs<rd?1:0```|
|```ret```|G Type|1011|```ret```|Sets pc to the value in ra|```pc=ra```|
|```add```|G Type|1100|```add .rs [.rm]```|Adds rs into the accumulator*|``` |[rm]+=rs```|
|```sub```|G Type|1101|```sub .rs [.rm]```|Subtracts rs from the accumulator*|```[rm]-=rs```|
|```and```|G Type|1110|```and .rs [.rm]```|Ands rs with the accumulator*|```[rm]^=rs```|
|```orr```|G Type|1111|```orr .rs [.rm]```|Ors rs with the accumulator*|```[rm]|=rs```|
***optional argument of .rm specifies an accumulator register to operate on (defaults to .m0)**

## Common Assembly/Machine Language Fragments
### Loading an address into a register
```c
ldi	.f0	addr
lda	.f0[0] .f1		
```
##### Machine Code Translation (assuming the value stored in addr is 280)
```c
0x0		0001000000000000
0x2		0000000100011000
0x4 	0000000000000001
0x6		0000000000000000
```

### Sum Values from x (a0) to y (a1) assuming x < y

```c
	cop	.a0 .m0
	cop .a0 .m1
	ldi	.f0 1

loop:
	add .f0 .m1
	add	.m1
	slt	.m1 .a1
	bne	.z0 .cr loop
```

##### Machine Code Translation (Assuming the address of loop is 0x8)
```c 
0x0		1000101101110011
0x2		1000101101110100
0x4 	0001000000000000
0x6		0000000000000001
0x8		1100000000110100
0xA		1100110100110011
0xC		1010110100101110
0xE		0110111111111001
0x01	0000000000001000
```

### Modulus

```c
loop: 
	add	.a1
	slt	.a0	.m0
	bne	.z0	.cr	loop
	sub	.a1
	cop	.a0	.m1
	sub	.m0	.m1
```

##### Machine Language Translation (Assuming the address of loop is at 0x0)
```c
0x0		1100101110110011
0x2		1010101101110011
0x4		0110111111111001
0x6		0000000000000000
0x8		1101101110110011
0xA		1000101101110011
0xC		1101110011110100
```

### Euclid's Algorithm
The following is an implementation of Euclid's algorithm in C which we converted to BAEJ
```c
// Find m that is relatively prime to n.
int
relPrime(int n)
{
   int m;

   m = 2;

   while (gcd(n, m) != 1) {  // n is the input from the outside world
     m = m + 1;
   }

   return m;
}

// The following method determines the Greatest Common Divisor of a and b
// using Euclid's algorithm.
int
gcd(int a, int b)
{
  if (a == 0) {
    return b;
  }

  while (b != 0) {
    if (a > b) {
      a = a - b;
    } else {
      b = b - a;
    }
  }

  return a;
}
```
#### BAEJ Translation
```mips
# The following is a function to find the greatest common divisor
gcd:	bne .a0 .z0 cont
		cop .a1 .v0
		ret
		
		cop .a0 .m0			# Copy arguments into accumulators
		cop .a1 .m1

cont:	beq .m1 .z0 end		# While b != 0
		slt .m1 .m0
		beq .cr .z0 else	# If a > b
		sub .m1
		bop cont
		
else:	sub .m0 .m1			# Else
		bop cont
		
end:	cop .m0 .v0
		ret
		
# The following is a function to find the first relative prime of a number n
# .m0 stores value of m, .a0 stores value of n
relP:	ldi .m0 2

loop:	cop .m0 .a1				
		cal gcd
		ldi .t1 1
		beq .v0 .t1 done	# While gcd(n,m) != 1
		add .t1				# m = m + 1
		bop loop

done:	cop .m0 .v0
		ret					# return m
```
#### Machine Code Translations
```
# Greatest Common Divisor
		0110 101101 111111
		(cont)
		
		1000 101110 111011
		
		1011 000000 000000
		
		1000 101101 110011
		
		1000 101110 110100
		
		0101 110100 111111
		(end)
		
		1010 110100 110011
		
		0101 111010 111111
		(else)
		
		1101 110100 000000
		
		0011 0000 0000 0000
		(cont)
		
		1101 110011 110100
		
		0011 0000 0000 0000
		(cont)
		
		1000 101101 111011
		
		1011 0000 0000 0000
		
# Relative Prime
		0001 110011 000000	
		0000 000000 000010
		
		1000 110011 101110
		
		0100 (gcd)
		
		0001 010001 000000
		0000 000000 000001
		
		0101 111011 010001
		(done)
		
		1100 010001 000000
		
		0011 0000 0000 0000
		(loop)
		
		1000 110011 111011
		
		1011 0000 0000 0000


```
