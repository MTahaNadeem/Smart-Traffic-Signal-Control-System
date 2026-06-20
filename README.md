📄 1. Abstract
Traffic congestion is a common problem in modern cities, often caused by fixed-time traffic signals that cannot adapt to fluctuating road conditions. This project proposes a Smart Traffic Signal Control System implemented using x86 assembly language that controls traffic signal timing based on dynamic changes in traffic density.  

The system models realistic traffic behavior by taking an input for vehicle density (low, medium, or high) and automatically adjusting the green signal duration accordingly. This project demonstrates how complex, real-life control systems can be designed with a low-level language interacting directly with processor registers, memory, and control flow mechanisms. It highlights core Computer Organization and Assembly Language (COAL) concepts, including conditional branching, looping, counters, arithmetic operations, memory handling, and interrupt-based input/output.  

💡 2. Introduction
Traffic Signal Systems are vital for managing vehicle movement and maintaining traffic flow in cities. Traditional traffic lights operate on fixed-length timers, which can cause unnecessary delays during low traffic and severe congestion during heavy traffic. To solve this, smart control systems are designed to identify the volume of approaching cars and adjust the green or red light durations on a continuing basis.  

This project simulates adaptive traffic signals by demonstrating how traffic density data can be utilized to optimize signal timing. Building this system in Assembly Language provides a deep understanding of low-level instruction sets and hardware interactions. It utilizes techniques such as conditional statements, comparisons, loop constructs, and delay mechanisms, laying the groundwork for building embedded and real-time control systems.  

⚙️ 3. Methodology
3.1 Overall Functionality
The Smart Traffic Light Control System adjusts the duration of signals based on traffic density by using variable lengths for the green light. Density is represented by a single user-provided value, allowing the system to categorize the traffic as low, medium, or high, and assign an appropriate active time for the green signal. This simulates real-world embedded traffic controllers using highly efficient assembly language instructions.  

3.2 Assumptions and Scope
To ensure a manageable implementation, the system operates under the following assumptions:

Traffic density is inputted as a numeric value: 1 = Low traffic, 2 = Medium traffic, 3 = High traffic.  

The system controls a single lane of traffic at a time, utilizing delay loops to create the appearance of timing.  

There are no external sensors involved; the system relies entirely on user input.  

3.3 Detailed Step-by-Step Logic
Initialization of System: The data segment is initialized, default signal timings are stored in memory, and welcome messages are prepared using register configuration.  

Display System Instructions: The system guides the user to input 1, 2, or 3 based on traffic volume using interrupt-based output (INT) and string handling.  

Traffic Density Input: The system awaits keyboard input, stores the value in a register, and converts the ASCII value to a numeric format to simulate sensor data.  

Traffic Density Evaluation: The input is compared against predefined conditions (1, 2, or 3) using CMP instructions and conditional jumps (JE, JNE) to route execution to the appropriate logic block.  

Signal Timing Assignment: The system assigns a short, moderate, or long green signal time based on the evaluated density, storing the value in a counter variable for delay loops.  

Green Signal Activation: The green signal message is displayed, and a delay loop runs for the assigned duration, utilizing register decrement and comparison.  

Yellow Signal Transition: A short, fixed delay is applied to the yellow signal to ensure a safe transition between states.  

Red Signal Activation: The red signal message is outputted, simulating stopped traffic and preparing the system for the next cycle.  

System Loop or Termination: The program either repeats for continuous monitoring or terminates gracefully via a program termination interrupt.  

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

🖥️ 5. Output Execution
The program is designed to be assembled and run using an x86 emulator like DOSBox. Upon execution, it prompts the user to enter the traffic density (1, 2, or 3) and visually simulates the light cycle by sequentially outputting the GREEN, YELLOW, and RED statuses with appropriate delays corresponding to the entered density.  
DOCX
