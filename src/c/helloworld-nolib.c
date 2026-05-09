/* PURPOSE: Write the message "hello world" and exit, with no
 *          C library — direct system calls only.
 *
 * VARIABLES:
 *   %eax holds the syscall number
 *   %ebx holds the first argument (fd / status)
 *   %ecx holds the second argument (buffer)
 *   %edx holds the third argument (length)
 */

#include "linux.h"

static const char helloworld[] = "hello world\n";

__attribute__((noreturn)) void _start(void) {
    __asm__ volatile("int $0x80"
                     :
                     : "a"(SYS_WRITE),
                       "b"(STDOUT),
                       "c"(helloworld),
                       "d"(sizeof(helloworld) - 1));

    __asm__ volatile("int $0x80"
                     :
                     : "a"(SYS_EXIT),
                       "b"(0));
    __builtin_unreachable();
}
