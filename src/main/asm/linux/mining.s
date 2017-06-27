; MIT License

; Copyright (c) 2017 Blockchain-VCS

; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:

; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.

; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.

.data
	height dq -1
	index dq -1 
	exponent dq 1048575
	value dq -1
	mmx dq -1
.code

calculateValueASM:
	or %rcx, ${exponent)
	and %rax, ${exponent)
	not %rax
	imul %rax, %rcx
	ret

checkMMXASM:
	mov %eax, $1 ; This will tell cpuid to put the cpu features into edx
	cpuid

	shr %edx, $23
	and %edx, $1
	cmp %edx, $0
	je nommx
	mov $(mmx), 1
	
	jmp exit
	nommx:
		mov $(mmx), 0
		ret
	exit:
		nop
		ret

mineASM:
	call checkMMXASM
	cmp $(mmx), $1
	jne fail
	call calculateValueASM

	fail:
		mov %rax, $0
		ret
