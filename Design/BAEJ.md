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
|```cop```|G Type|1000|```cop .rs .rd```|Copies the value of rs to rd while retaining the original value of rs|```rd=rs```|
|```mov```|G Type|1001|```mov .rs .rd```|Copies the value of rs to rd and places a value of 0 into rs|```rd=rs```<br>```rs=0```|
|```slt```|G Type|1010|```slt .rs .rd```|Sets cr to a value other than 0 if rs is less than rd|```t0=rs<rd?1:0```|
|```ret```|G Type|1011|```ret```|Sets pc to the value in ra|```pc=ra```|
|```add```|G Type|1100|```add .rs [.rm]```|Adds rs into the accumulator*|``` |[rm]+=rs```|
|```sub```|G Type|1101|```sub .rs [.rm]```|Subtracts rs from the accumulator*|```[rm]-=rs```|
|```and```|G Type|1110|```and .rs [.rm]```|Ands rs with the accumulator*|```[rm]^=rs```|
|```orr```|G Type|1111|```orr .rs [.rm]```|Ors rs with the accumulator*|```[rm]|=rs```|
***optional argument of .rm specifies an accumulator register to operate on(defualts to .m0)**

### Common Assembly Language Fragments
Loading an address into a register
```c

```


### Sum Values from x (a0) to y (a1) assuming x < y
```c
	cop	.a0 .m0
	cop .a0 .m1

loop:
	addi 1 .m1
	add  .m1
	slt	 .m1
	bne  .z0 .cr loop
			.
			.
			.
```

### Euclid's Algorithm
The following is an implementation of Euclid's algorithm in C which we converted to JAEB
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
```mips
# The following is a function to find the greatest common divisor
gcd:	bne .a0 .z0 cont
		cop .a1 .v0
		ret
		
cont:	beq .a1 .z0 end
		slt .a1 .a0
		beq .t0 .z0 else
		cop .a0 .m0
		sub .a1 .a0
		bop cont
		
else:	cop .a1 .m0
		sub .a0 .a1
		bop cont
		
end:	cop .a0 .v0
		ret
```

