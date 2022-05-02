# Bootloader

First of all Bootloader is a program written mostly in assembler (because of the limited memory), which is a springboard used to load the operating system to memory. This article describes it and how it relates to other components of the operating system. 

In the next part there is a description how I changed its default behavior to create a simple game.

In typical situations the bootloader was a program that was run by firmware such as the bios. The bios location is a rom, that is a memory location that does not disappear from the computer memory and the cpu always has access to it.

The firmware was run by the cpu by hardcoding this behavior by constructing an electrical circuit within the cpu.

The idea is that this is how the first instruction to be executed by the processor was stored, and this value was the memory cell number where the firmware started.

The firmware searched the disks and devices for the correct bit pattern in the initial bytes of the media.
If the pattern matched, it proceeded to copy the program to the operating memory, which is defined by the standards to be about 510-512 bytes. Then, it sets the instruction execution address to another standard value (where the bootloader was loaded), and then the bootloader starts to be executed by the processor.

The 512 bytes size is related to the address modes. The point is that for some reason( unclear to anyone except Intel) the processor must emulate the older processors one by one. And in this mode, in which the bootloader should work, it is 512 bytes. 

Under normal circumstances, the bootloader, is a program that accesses and understands the file systems on disks. So in some standardized file (with a known name) is stored information about available to load operating systems. 

Then the bootloader takes the code of such a system ( all or part of it ) and loads it into RAM, then jumps to the place where it loaded it and then this os starts executing.

In our case we have a game instead :). It was supposed to be a bit more ambitious and artistic, but you can't do much on these 512 bytes. I brought the project to the point where it became interactive. There was added a simple functionality of moving the option selection indicator. For now, you can see it on screens.

The program is using api provided by Bios. These types of instructions are called by a special processor command called interrupt. Then, in a given register we write what we actually ask for, that is the id of a given function and its arguments. 
Then, we execute a special command from the processor, then the processor runs the interrupt service code (stored somewhere in the bios area) and this code already gets the arguments, it knows where the target function is. 

Similarly, we activate hardware interrupt listening, and registering handlers (addresses) of functions that are supposed to do some predetermined (by us programmers) things like cleaning the screen, or moving the cursor in response to external events.

It is worth mentioning that the information presented above concerns Legacy Bios, in UEFI the firmware has much more permissions, and probably does not have to be limited to 512 bytes.

This whole process happens on one core, usually os runs the others by itself.
Commercial programs like Grub and LILO are those that pretend to be the operating system, i.e. it is their Bootloader that loads.
  


How to run it:
Potrzebne będzie qemu i nasm.

nasm:
sudo apt-get install nasm
                                                                                       





quemu: 
apt-get install qemu

Then you need to make a make-a like in the project files.
