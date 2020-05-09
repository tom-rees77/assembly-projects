# assembly-projects

Repository for some assembly projects from Microcomputer Organization course

456-sort.asm: A sort function

---------------------

456-clock.asm: A 12-hour clock
Specifications:

Overview: 

This program is a 24-hour clock that displays the time in a 12-hour format with AM and PM. 

 

Language: 

Assembly, x86/Intel. The clock program was designed and implemented using Microsoft's 16-bit Debug.exe assembler. 

 

Instructions: 

The source code is found in the file 456project.txt. To assemble, paste the code at the Debug prompt. A simpler way to execute the program quickly is by making a Batch file and using the source code file as input to the Debug.exe command as follows: 

Debug.exe < 456project.txt 

pause 

The source code file contains the execute command, g=100, therefore it will execute automatically. The user will then follow the on-screen instructions to initialize the clock. 

 

Implementation 

The program begins at a 100. The increment of the time is done through nested loops; the innermost loop being the seconds' ones-place is incremented once per second. Depending on the place position, either ones or tens-place, the successive loops will be incremented either five or ten times before returning to the calling loop. 

a 100: 

The program clears the screen and prints the introduction screen 

After the user reads the instructions and presses a key, the screen is cleared again 

The cursor is repositioned and the border design with “HR MIN SEC AM/PM” prompt is displayed 

200 is called to start the clock itself. 

 

a 125 

An old design, displaying just the “HR MIN SEC AM?PM” prompt. 

 

a 150 

Clear Screen routine. From here one may set the color for the text of the program. 

 

a 175 

Cursor position routine, top left corner. 

 

a 200 

This routine calls 225 to initialize the clock with the user's input after which it returns 

The next routine is 400, which begins the increment with the AM/PM routine. 

 

 

a 225 

Initializes the clock by calling two routines; 350 to position the cursor and 275 to read and print the character from the keyboard. 

 

a 275 

Uses interrupt 16 with AH = 00 as the BIOS scan code for a single character to read in a character from the keyboard and stores it in HEX in ASCII form. The routine then calls 300 to print the character in the AL register. 

 

a 300 

This routine prints the ASCII representation of the value in AL at the current cursor position. It is used for initialization and for the clock increment. Uses interrupt 10 with AH = 09 for character output of the ASCII value in AL. BX is used to contain the display-page in BH and background and color information in BL. CX is set to 01 as it is the number of characters to be printed. It uses interrupt 10 instead of interrupt 21 to facilitate the simpler manipulation of the character printout; in this case the colors were changed to a light red on black background. 

 

a 325 

This is the delay routine. A set of nested loops delays the execution of the next instruction by approximately one second. 

 

a 350 

General cursor positioning routine, positions the cursor to the position predefined in DX before the call to this function. 

 

a 375 

This routine will read the character at the cursor position. Uses interrupt 10 with AH = 08 to read a character; BH is the page number, set to 00. In the calling function, once the cursor is in the desired position, this function is called to read the character into AL; its color information is read into AH, but it is not used in this program. 

 

a 400 

This routine is the beginning of the clock increment routines. First it calls 450, the hour routine. Since the hour routine will take 12 hours to return, this routine will be ready to change AM to PM or vice-versa. After returning from the hour routine, this program checks what the current character is with 375, an A or a P and then swaps them accordingly. Then the routine will loop back to the line to call the hour function and the process begins again. 

 

a 450 

This routine increments the hours from 1 to 12. First it calls the minute routine, which takes 60 minutes to return, and then proceeds to increment the hours from the user's input read by a call to 375. 

 

 

 

a 550 – 600 

The minute routines increment the minutes. First, 550 will increment the tens-place and 600 will increment the ones-place. 600 calls the seconds routine and will return after 60 seconds. 600 will loop ten times, returning to 550 after ten minutes. 550 will loop six times (not considering the user may have put in a non-zero for the time. 

 

a 650 – 700 

As with the minutes, in the same manner, these functions will increment the seconds. 650 manages the tens place, whereas 700 increments the ones place. The ones place increment in this situation calls 325, the delay routine to delay approximately one second between second increments. 

 

a 800 

Prints the introduction and instruction message to the screen. Uses interrupt 21. 

 

a 0a00 

Defines the message to be printed for 800. Using db, define byte. 

 

a 0e00 

Prints the clock border. Uses interrupt 21. 

 

a 0f00 

Defines the border design for 0e00. 

 
