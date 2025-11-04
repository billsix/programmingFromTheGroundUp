BITS:=$(shell getconf LONG_BIT)

maxium: maximum.c
	clang     -m$(BITS) -S -O0 \
                  -fomit-frame-pointer -fno-asynchronous-unwind-tables \
                  -fno-unwind-tables -fno-dwarf2-cfi-asm -fno-stack-protector \
                  maximum.c
	clang     -m$(BITS) -o maximum maximum.s

