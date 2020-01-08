# Installing-RISCV-Toolchain-and-building-Rocketchip-SoC-port-for-ZYNQ-ultascale-plus-ZCU-102-FPGA
A shell script to install RISCV toolchain and build Rocketchip SoC on Ubuntu 18.04, and Fedora 
I have tested this script on Ubuntu 18.04 but hopefully it will work with all other linux versions 
***************************************************************************
This script will build/install the RISCV processor in the current directory.
 Execute this script in privilidge mode(sudo) because it will install many prerequsit software tools required to 
 build RISCV beside  cloning the relevant repsoitories. 
If it is not executing at host machine make it executable by running the following command in terminal.

$ sudo chmod 777 rc_fpga_install.sh    

to make is executable, or use  
$ chmod 744 rc_fpga_install.sh for current user only

IF your OS is Fedora please uncomment the requiered packeges installation command for Fedora and comment 
the Ubuntu's one below. follow the comments to get the right one.  
******************************************************************************

# Build and Run a C program on RISCV
To build and run a C program on RISCV please follow the istruction in file "Building and Running a program using RISCV" 
If it is not building your program check the PATH variable, does it contain path to your riscv-tools installation directory or not? if not then add the path then it will be able to properly locate the cross compiler required to generate the binary of riscv format plus other tools like spike required to run the program etc.

----------------------------------------------------------------
Testing Your Toolchain

Now that you have a toolchain, it'd be a good idea to test it on the quintessential "Hello world!" program. Exit the riscv-tools directory and write your "Hello world!" program. I'll use a long-winded echo command.


$ echo -e '#include <stdio.h>\n int main(void) { printf("Hello world!\\n"); return 0; }' > hello.c
OR
you can write your code using any text editor and save it as .c file

BUILDING RUNNING YOUR CODE

Then, build your program with riscv64-unknown-elf-gcc.

$ riscv64-unknown-elf-gcc -o hello hello.c

When you're done, you may think to do ./hello, but not so fast. We can't even run spike hello, because our "Hello world!" program involves a system call, which couldn't be handled by our host x86 system. We'll have to run the program within the proxy kernel, which itself is run by spike, the RISC-V architectural simulator. Run this command to run your "Hello world!" program:

$ spike pk hello

The RISC-V architectural simulator, spike, takes as its argument the path of the binary to run. This binary is pk, and is located at $RISCV/riscv-elf/bin/pk. spike finds this automatically. Then, riscv-pk receives as its argument the name of the program you want to run.

Hopefully, if all's gone well, you'll have your program saying, "Hello world!". 

--------------------------------------------------------------




# FPGA bitstream generation and testing 
kindly follow the guidelines given in https://github.com/li3tuo4/rc-fpga-zcu repository
