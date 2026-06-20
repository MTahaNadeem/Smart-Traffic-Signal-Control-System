[org 0x0100]

jmp start ;Unconditional Jump to Start

;Message section
msg1 db 13,10,"Enter Traffic Density (1=Low, 2=Medium, 3=High): $" ;Firstly disply to asking the traffic density
msgG db 13,10,"SIGNAL Status: GREEN (Go!)$"
msgY db 13,10,"SIGNAL Status: YELLOW (Prepare to stop)$"
msgR db 13,10,"SIGNAL Status: RED (Stop)$"
msgI db 13,10,"Invalid Input!$"

start:
    mov ax, cs  ; Move current code segment into AX    
    mov ds, ax  ; Initialize DS to point to the data segment (same as code segment here)

    ;Ask for the score
    mov dx, msg1  ; Load the msg1 into DX
    mov ah, 09h  ; DOS print string function
    int 0x21         

    mov ah, 01h   ; DOS function to read a single character from keyboard
    int 0x21        

 ; AL now contains ASCII code of the pressed key
    cmp al, '1'  ; Compare input with ASCII '1'
    je low_traffic  ; Jump to low_traffic if equal
    cmp al, '2'  ;  Compare input with ASCII '2'
    je medium_traffic  ; Jump to medium_traffic if equal
    cmp al, '3'  ; Compare input with ASCII '3'
    je high_traffic  ; Jump to high_traffic if equal
    jmp invalid  ; If none matched, jump to invalid input section

; Program Logic Section
low_traffic:
    mov bx, 10   ; Set short delay factor for low traffic
    jmp run_signal

medium_traffic:
    mov bx, 30   ; Set medium delay factor for medium traffic
    jmp run_signal

high_traffic:
    mov bx, 60   ; Set long delay factor for high traffic

run_signal:
    mov dx, msgG   ; Load offset of GREEN signal message
    mov ah, 09h  ; DOS print string function
    int 0x21   ; Display GREEN signal
    call delay_proc  ; Call delay procedure (pause based on BX)

    mov dx, msgY  ; Load offset of YELLOW signal message
    mov ah, 09h  ; DOS print string function
    int 0x21  ; Display YELLOW signal
    call delay_proc  ; Call delay procedure

    mov dx, msgR  ; Load offset of RED signal message
    mov ah, 09h  ; DOS print string function
    int 0x21  ; Display RED signal
    call delay_proc  ; Call delay procedure

    jmp exit  ; Jump to program exit

; Invalid Input 
invalid:
    mov dx, msgI  ; Load offset of invalid input message
    mov ah, 09h  ; DOS print string function
    int 0x21  ; Display invalid input message

; Exit program
exit:
    mov ax, 0x4c00  ; DOS terminate program function
    int 0x21  ; Exit program

; Nested Delay Subroutine
; This uses BX to determine how many times to run the heavy loop
delay_proc:
    push cx  ; Save CX to stack (used in loop)
    push bx  ; Save BX on stack (used as outer loop counter)
    
outer_loop:
    mov cx, 0xFFFF  ; Load CX with 65,535 for inner loop
inner_loop:
    nop  ; Do nothing (takes time, consumes CPU)
    loop inner_loop  ; Repeat 65,535 times
    
    dec bx  ; Decrement BX (outer loop counter)
    jnz outer_loop  ; If BX is not zero, run the 65,534 loop again
    
    pop bx  ; Restore original BX value
    pop cx  ; Restore original CX value
    ret  ; Return from subroutine
 
