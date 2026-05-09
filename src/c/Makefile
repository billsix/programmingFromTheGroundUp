# Build the C ports of the book's assembly examples.
#
# Each .c is first compiled to a .s with educational flags so the
# generated assembly stays readable (no frame pointer, no CFI/unwind
# tables, no stack canaries).  The .s is then assembled and linked.
#
# Freestanding programs link with -nostdlib and provide their own
# _start.  helloworld-lib and printf-example are the exception —
# they link against libc and use the normal main() entry.

CC = clang

# Flags used to generate readable, book-like assembly from C.
GEN_FLAGS = -m32 -S -O0 \
            -fomit-frame-pointer -fno-asynchronous-unwind-tables \
            -fno-unwind-tables -fno-dwarf2-cfi-asm -fno-stack-protector

LINK_FLAGS_NOSTDLIB = -m32 -nostdlib
LINK_FLAGS_LIBC    = -m32

FREESTANDING = exit \
               maximum \
               helloworld-nolib \
               power \
               factorial \
               conversion-program \
               toupper-nomm-simplified \
               read-records \
               write-records \
               add-year

LIBC_PROGRAMS = helloworld-lib \
                printf-example

all: $(FREESTANDING) $(LIBC_PROGRAMS)

# ---------- pattern rule: .c -> .s ----------------------------------
%.s: %.c
	$(CC) $(GEN_FLAGS) $< -o $@

# ---------- single-file freestanding programs -----------------------
exit: exit.s
	$(CC) $(LINK_FLAGS_NOSTDLIB) -o $@ $^

maximum: maximum.s
	$(CC) $(LINK_FLAGS_NOSTDLIB) -o $@ $^

helloworld-nolib: helloworld-nolib.s
	$(CC) $(LINK_FLAGS_NOSTDLIB) -o $@ $^

power: power.s
	$(CC) $(LINK_FLAGS_NOSTDLIB) -o $@ $^

factorial: factorial.s
	$(CC) $(LINK_FLAGS_NOSTDLIB) -o $@ $^

toupper-nomm-simplified: toupper-nomm-simplified.s
	$(CC) $(LINK_FLAGS_NOSTDLIB) -o $@ $^

# ---------- multi-file freestanding programs ------------------------
conversion-program: conversion-program.s count-chars.s integer-to-string.s write-newline.s
	$(CC) $(LINK_FLAGS_NOSTDLIB) -o $@ $^

read-records: read-records.s read-record.s count-chars.s write-newline.s
	$(CC) $(LINK_FLAGS_NOSTDLIB) -o $@ $^

write-records: write-records.s write-record.s
	$(CC) $(LINK_FLAGS_NOSTDLIB) -o $@ $^

add-year: add-year.s read-record.s write-record.s
	$(CC) $(LINK_FLAGS_NOSTDLIB) -o $@ $^

# ---------- libc programs -------------------------------------------
helloworld-lib: helloworld-lib.s
	$(CC) $(LINK_FLAGS_LIBC) -o $@ $^

printf-example: printf-example.s
	$(CC) $(LINK_FLAGS_LIBC) -o $@ $^

# ---------- housekeeping --------------------------------------------
clean:
	rm -f $(FREESTANDING) $(LIBC_PROGRAMS) *.s

.PHONY: all clean
