%.o: %.s
	as --32 -g $< -o $@

exit: exit.o
	ld -m elf_i386 exit.o -o exit

all: exit


clean:
	rm *.o
	rm exit
