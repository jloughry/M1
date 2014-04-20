M1, a sixteen bit (very) reduced instruction set computer
=========================================================

![photograph](https://github.com/jloughry/M1/raw/master/M1-hdr-thumb.jpeg)

(higher resolution photo [here](https://github.com/jloughry/M1/raw/master/M1-hdr-full.jpeg))

System Architecture
-------------------

M1 is a 16-bit computer designed by me in 1991 after I decided I lacked a deep enough
understanding of computer architecture.  It was designed along RISC principles; the
instruction set consists of eight instructions.

(opcodes are in octal)

	00 - HALT stop processing
	01 - INC  increment the contents of the target address by 1
	02 - INC  increment the contents of the target address by 1
	03 - CLR  set the contents of the target address to zero
	04 - CMP  contents of the target address are compared with zero; if
	          they are different, the RSLT flag is set.
	05 - BNZ  if the RSLT flag is set, the programme counter is loaded
	          with the contents of the target address.
	06 - IN   the target address is loaded from the input port.
	07 - OUT  the output port is sent the contents of the target address.

Two's complement arithmetic is used throughout.

I was inspired to do this by the Operating Systems theory classes taught by Professor
Gary Nutt at the University of Colorado in Boulder.  A couple of years after leaving
school, I brought the computer to his office to demonstrate it and explained that the
entire project had been done because of an exchange that happened in class one day:

> Prof. Nutt: Do you know what the control unit is?
> 
> Student: Sure...it's a box with magic in it.

I thought that level of understanding was unsatisfactory, so I did this.

![schematic](https://github.com/jloughry/M1/raw/master/M1_schematic_page_1_of_2.png)

![schematic](https://github.com/jloughry/M1/raw/master/M1_schematic_page_2_of_2.png)

A simple programme for 16-bit I/O illustrating emulation of shift and rotate instructions is
here.  Note that it uses several convenient synthetic instructions provided by the assembler:

	SETUP:    CLR  jump_flag            ;;; set jump flag
	          INC  jump_flag
	READ1:    IN   buffer               ;;; read first byte
	          BNZ  COPY_HI
	          CMP  jump_flag
	          BNZ  READ1
	COPY_HI:  CLR  destination          ;;; copy first byte
	          COPY destination, buffer  ;;; into destination
	DATA:     DATA 0x00FF
	SHIFT_HI: MUL  destination, DATA    ;;; left-shift 8 bits
	READ2:    IN   buffer               ;;; read second byte
	          BNZ  COPY_LO
	          CMP  jump_flag
	          BNZ  READ2
	ADD_LOW:  ADD  destination, buffer  ;;; copy into lower
	          RET  ret_addr             ;;; 8 bits of word

A gate-level simulator, used during design of the hardware for setting timings, ran on the
Apple ][+.

RISC reduction
--------------

I actually discovered the concept of Single Instruction Set
Computing<sup>[&Dagger;](#note-double-dagger)</sup> (SISC) or a One Instruction Set
Computer<sup>[&dagger;](#note-dagger)</sup> (OISC) independently at about the same
time, according to my laboratory notebook. The single (two address) instruction was
`decrement and branch if zero`.<sup>[*](#note-star)</sup> Since there is only one
opcode, no programme is actually required; the software consists of an unbounded
sequence of data (usually thought of as an endless loop) that is modified in place
by the CPU.

I never implemented it, but I designed it, and could have published first, if only I had
known how to at the time. Oh, well...

Notes
-----

<a name="note-star"/><sup>*</sup> [One Instruction Set
Computer](http://en.wikipedia.org/wiki/One_instruction_set_computer).

<a name="note-dagger"/><sup>&dagger;</sup> Douglas W. Jones. "The Ultimate RISC".
*ACM SIGARCH Computer Architecture News* **16**(3), pp. 48&ndash;55 (1988).

<a name="note-double-dagger"/><sup>&Dagger;</sup> Jeff Laughton. [One-bit Computing at 60
Hertz](http://laughtonelectronics.com/Arcana/One-bit%20computer/One-bit%20computer.html)
(2014). Cited by [HN](https://news.ycombinator.com/item?id=7616831).

