;Author Information
;  Author name: Kevin Ochoa
;  Author email: ochoakevinm@gmail.com
;Project Information
;  Project title: Manipulating Stack Frames
;  Purpose: The purpose of this assignment is to learn more about stack frames.
;  Project files: C1.cpp, C2.cpp, C3.cpp, C4.cpp, c5.asm
;Module Information
;  This module's call name: C5
;  Date last modified: 2015-Dec-14
;  Language: X86-64
;  Purpose: This is subprogram number 5 out of 5 designed for the purpose of investigating the role of the system stack in the process calling subprograms. 
;  Filename: C5.asm
;Translator Information:
;   Linux: nasm -f elf64 -l C5.lis -o C5.o C5.asm
;References and Credits:
;   Holliday, Floyd. Floating Point Input and Output. N.p., 1 July 2015. Web. 14 Dec 2015
;   Holliday, Floyd. Parameter Passing Demonstration. N.p., 15 July 2015, Web. 14 Dec 2015
;Format Information
;  Page width: 172 columns
;  Begin Comments: 61
;Permission information: No restrictions on posting this file online.
;===== Beginning of C5.asm ================================================================================================================================================

%include "debug.inc"                                        ;Debug tool used to show contents of stack

extern printf                                               ;External C++ function for writing to standard output device

extern scanf                                                ;External C++ function for reading from standard input device

global C5                                                   ;Allows C5 to be called outside of file

segment .data                                               ;Place for initialized data

;===== Message and Format Declarations ====================================================================================================================================

startmessage db "Function C5 has begun",10,0

callervalue db "One incoming value was received: %1.1lf",10,0

first_dumpstack db "Here is the dumpstack you need",10,10,0

stackchange db "Changes have been made to the stack, here is the stack for verification.",10,0

endmessage db "This assembly module is now finished and will return control to the caller.",10,0

stringformat db "%s",0

segment .bss                                                ;Place for pointers to un-initialized space

;===== Entry point for C5.asm =============================================================================================================================================

segment .text                                               ;Place for executable instructions

C5:                                                         ;Entry point for C5

push       rbp                                              ;This marks the start of a new stack frame for this function.
mov        rbp, rsp                                         ;rbp holds the address of the start of this new stack frame.

;===== Backup the value passed in before printing =========================================================================================================================

push qword 0                                                ;Reserve 8 bytes of storage
movsd      [rsp], xmm0                                      ;Place a backup copy of the caller value in rsp

;===== Display Start Message ==============================================================================================================================================

push       qword 0                                          ;Get back on the boundary by pushing a qword
mov qword  rax, 0                                           ;No data from SSE will be printed
mov        rdi, stringformat                                ;"%s"
mov        rsi, startmessage                                ;"Function c5 has begun"
call       printf                                           ;Call a library function to make the output    
pop        rax						    ;Free up space

;===== Display the number passed in by C4 =================================================================================================================================

movsd      xmm0, [rsp]    				    ;move caller value back into xmm0 for printing
pop        rax                                              ;pop the value from the integer stack

mov        rax, 1                                           ;One floating point number will be printed
mov        rdi, callervalue                                 ;"One incoming value was received: %1.1lf"
call       printf                                           ;Call a library function to make the output

;===== Inform user that stack will be displayed  ==========================================================================================================================

mov qword  rax, 0                                           ;No data from SSE will be printed
mov        rdi, stringformat                                ;"%s"
mov        rsi, first_dumpstack                             ;"Here is the dumpstack you need"
call       printf                                           ;Call a library function to make the output

dumpstack 0,0,35                                            ;show contents of stack before changing values

;===== Change values belonging to C4 ======================================================================================================================================

mov        rbx, 0x3FF0000000000000                          ;constant 1.0 needed for addition
push       rbx						    ;place the constant on the integer stack
movsd      xmm0, [rsp]					    ;place 1.0 into xmm0
pop        rax					            ;discard 1.0 from integer stack

mov        rbx, 0xC010000000000000                          ;Constant -4.0 needed to change values.
push       rbx                                              ;Place the constant on the integer stack.
movsd      xmm1, [rsp]                                      ;place -4.0 in xmm1
pop        rax                                              ;Discard -4.0 from the integer stack

movsd      [rsp+8*5], xmm1				    ;change -1.5 in C4 into -4.0
movsd      [rsp+8*6], xmm1				    ;change  0.6 in C4 into -4.0
movsd      [rsp+8*7], xmm1				    ;change  2.1 in C4 into -4.0
movsd      [rsp+8*8], xmm1				    ;change  4.3 in C4 into -4.0
movsd      [rsp+8*9], xmm1				    ;change -2.3 in C4 into -4.0

;===== Change values belonging to C3 ======================================================================================================================================

addsd      xmm1, xmm0                                       ;add 1.0 to -4.0 xmm1 now holds -3.0 

movsd      [rsp+8*14], xmm1				    ;change -2.3 in C3 into -3.0
movsd      [rsp+8*15], xmm1				    ;change  7.9 in C3 into -3.0
movsd      [rsp+8*16], xmm1				    ;change  2.2 in C3 into -3.0
movsd      [rsp+8*17], xmm1				    ;change -2.7 in C3 into -3.0

;===== Change values belonging to C2 ======================================================================================================================================

addsd      xmm1, xmm0                                       ;add 1.0 to -3.0 xmm1 now holds -2.0

movsd      [rsp+8*23], xmm1				    ;change  9.1 in C2 into -2.0
movsd      [rsp+8*24], xmm1				    ;change -2.7 in C2 into -2.0
movsd      [rsp+8*25], xmm1				    ;change  5.2 in C2 into -2.0 

;===== Change values belonging to C1 ======================================================================================================================================

addsd      xmm1, xmm0                                       ;add 1.0 to -2.0 xmm1 now holds -1.0

movsd      [rsp+8*30], xmm1				    ;change -5.2 in C1 into -1.0
movsd      [rsp+8*31], xmm1				    ;change -1.6 in C1 into -1.0

dumpstack 1,0,35                                            ;show contents of stack again

;===== Display End Message ================================================================================================================================================

mov qword  rax, 0                                           ;No data from SSE will be printed
mov        rdi, stringformat                                ;"%s"
mov        rsi, endmessage                                  ;"This assembly module is now finished and will return control to the caller."
call       printf                                           ;Call a library function to make the output 

;====== Restore the Base Pointer ==========================================================================================================================================

pop        rbp
ret

;===== End of C5.asm ======================================================================================================================================================









