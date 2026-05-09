/* PURPOSE: Write a single newline character to the given fd.
 *
 * INPUT:   fd - the file descriptor to write to
 *
 * The original asm keeps "\n" as a labeled byte in .data.  Here
 * we use a static const char with the same effect — the linker
 * places it in .rodata.
 */

#include "linux.h"

void write_newline(int fd) {
    static const char newline = '\n';
    __asm__ volatile("int $0x80"
                     :
                     : "a"(SYS_WRITE),
                       "b"(fd),
                       "c"(&newline),
                       "d"(1));
}
