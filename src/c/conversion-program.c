/* PURPOSE: Demonstrates integer2string by converting the constant
 *          824 to a decimal string and writing it to stdout.
 *
 * Links against the helper library files: count-chars.c,
 * integer-to-string.c, and write-newline.c.
 */

#include "linux.h"

extern int  count_chars(const char *s);
extern void integer2string(int value, char *buffer);
extern void write_newline(int fd);

static char tmp_buffer[16];

__attribute__((noreturn)) void _start(void) {
    /* Convert 824 to a string */
    integer2string(824, tmp_buffer);

    /* Get the character count for our system call */
    int len = count_chars(tmp_buffer);

    /* Write it to STDOUT */
    __asm__ volatile("int $0x80"
                     :
                     : "a"(SYS_WRITE),
                       "b"(STDOUT),
                       "c"(tmp_buffer),
                       "d"(len));

    /* Trailing newline */
    write_newline(STDOUT);

    /* Exit */
    __asm__ volatile("int $0x80"
                     :
                     : "a"(SYS_EXIT),
                       "b"(0));
    __builtin_unreachable();
}
