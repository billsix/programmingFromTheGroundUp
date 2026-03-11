all: maximum \
     exit

maximum: maximum.c
	clang     -m32 -S -O0 \
                  -fomit-frame-pointer -fno-asynchronous-unwind-tables \
                  -fno-unwind-tables -fno-dwarf2-cfi-asm -fno-stack-protector \
                  maximum.c
	clang     -m32 \
                  -nostdlib \
                  -o maximum maximum.s


exit: exit.c
	clang     -m32 -S -O0 \
                  -fomit-frame-pointer -fno-asynchronous-unwind-tables \
                  -fno-unwind-tables -fno-dwarf2-cfi-asm -fno-stack-protector \
                  exit.c
	clang     -m32 \
                  -nostdlib \
                  -o exit exit.s


