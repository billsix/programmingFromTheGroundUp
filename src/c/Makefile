BITS:=$(shell getconf LONG_BIT)

all: maximum \
     exit

maxium: maximum.c
	clang     -m$(BITS) -S -O0 \
                  -fomit-frame-pointer -fno-asynchronous-unwind-tables \
                  -fno-unwind-tables -fno-dwarf2-cfi-asm -fno-stack-protector \
                  maximum.c
	clang     -m$(BITS) \
                  -nostdlib \
                  -o maximum maximum.s


exit: exit.c
	clang     -m$(BITS) -S -O0 \
                  -fomit-frame-pointer -fno-asynchronous-unwind-tables \
                  -fno-unwind-tables -fno-dwarf2-cfi-asm -fno-stack-protector \
                  exit.c
	clang     -m$(BITS) \
                  -nostdlib \
                  -o exit exit.s


