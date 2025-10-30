maxium: maximum.c
	gcc     -m32 -S -O0 \
                  -fomit-frame-pointer -fno-asynchronous-unwind-tables \
                  -fno-unwind-tables -fno-dwarf2-cfi-asm -fno-stack-protector \
                  maximum.c
	gcc    -m32 -o maximum maximum.s

