📄 1. Abstract
Traffic congestion is a common problem in modern cities, often caused by fixed-time traffic signals that cannot adapt to fluctuating road conditions. This project proposes a Smart Traffic Signal Control System implemented using x86 assembly language that controls traffic signal timing based on dynamic changes in traffic density.  
DOCX
+ 1

The system models realistic traffic behavior by taking an input for vehicle density (low, medium, or high) and automatically adjusting the green signal duration accordingly. This project demonstrates how complex, real-life control systems can be designed with a low-level language interacting directly with processor registers, memory, and control flow mechanisms. It highlights core Computer Organization and Assembly Language (COAL) concepts, including conditional branching, looping, counters, arithmetic operations, memory handling, and interrupt-based input/output.  
DOCX
+ 2

💡 2. Introduction
Traffic Signal Systems are vital for managing vehicle movement and maintaining traffic flow in cities. Traditional traffic lights operate on fixed-length timers, which can cause unnecessary delays during low traffic and severe congestion during heavy traffic. To solve this, smart control systems are designed to identify the volume of approaching cars and adjust the green or red light durations on a continuing basis.  
DOCX
+ 2

This project simulates adaptive traffic signals by demonstrating how traffic density data can be utilized to optimize signal timing. Building this system in Assembly Language provides a deep understanding of low-level instruction sets and hardware interactions. It utilizes techniques such as conditional statements, comparisons, loop constructs, and delay mechanisms, laying the groundwork for building embedded and real-time control systems.  
DOCX
+ 2

⚙️ 3. Methodology
3.1 Overall Functionality
The Smart Traffic Light Control System adjusts the duration of signals based on traffic density by using variable lengths for the green light. Density is represented by a single user-provided value, allowing the system to categorize the traffic as low, medium, or high, and assign an appropriate active time for the green signal. This simulates real-world embedded traffic controllers using highly efficient assembly language instructions.  
DOCX
+ 2

3.2 Assumptions and Scope
To ensure a manageable implementation, the system operates under the following assumptions:

Traffic density is inputted as a numeric value: 1 = Low traffic, 2 = Medium traffic, 3 = High traffic.  
DOCX

The system controls a single lane of traffic at a time, utilizing delay loops to create the appearance of timing.  
DOCX

There are no external sensors involved; the system relies entirely on user input.  
DOCX

3.3 Detailed Step-by-Step Logic
Initialization of System: The data segment is initialized, default signal timings are stored in memory, and welcome messages are prepared using register configuration.  
DOCX

Display System Instructions: The system guides the user to input 1, 2, or 3 based on traffic volume using interrupt-based output (INT) and string handling.  
DOCX

Traffic Density Input: The system awaits keyboard input, stores the value in a register, and converts the ASCII value to a numeric format to simulate sensor data.  
DOCX

Traffic Density Evaluation: The input is compared against predefined conditions (1, 2, or 3) using CMP instructions and conditional jumps (JE, JNE) to route execution to the appropriate logic block.  
DOCX

Signal Timing Assignment: The system assigns a short, moderate, or long green signal time based on the evaluated density, storing the value in a counter variable for delay loops.  
DOCX

Green Signal Activation: The green signal message is displayed, and a delay loop runs for the assigned duration, utilizing register decrement and comparison.  
DOCX

Yellow Signal Transition: A short, fixed delay is applied to the yellow signal to ensure a safe transition between states.  
DOCX

Red Signal Activation: The red signal message is outputted, simulating stopped traffic and preparing the system for the next cycle.  
DOCX

System Loop or Termination: The program either repeats for continuous monitoring or terminates gracefully via a program termination interrupt.  
DOCX

📝 4. Pseudocode
Plaintext
START

Initialize data and registers
Display welcome message
Display traffic density instructions

INPUT traffic-density

IF traffic-density == 1
    green-time = SHORT
ELSE IF traffic-density == 2
    green-time = MEDIUM
ELSE IF traffic-density == 3
    green-time = LONG
ELSE
    Display "Invalid Input"
    EXIT
END IF

Display "Green Signal ON"
Delay for green-time

Display "Yellow Signal ON"
Delay for fixed-time

Display "Red Signal ON"
Delay for fixed-time

END
  
DOCX

💻 5. Source Code
Code snippet
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
  
DOCX

🖥️ 6. Output Execution
The program is designed to be assembled and run using an x86 emulator like DOSBox. Upon execution, it prompts the user to enter the traffic density (1, 2, or 3) and visually simulates the light cycle by sequentially outputting the GREEN, YELLOW, and RED statuses with appropriate delays corresponding to the entered density.  
DOCX
+ 1
