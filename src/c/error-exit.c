/* PURPOSE: Print an error code and message to STDERR and exit
 *          with status 1.
 *
 * INPUT:   error_code - null-terminated short identifier
 *          error_msg  - null-terminated descriptive message
 *
 * Library file — no _start.  Linked into programs that need a
 * structured error-and-die helper.
 */

#include "linux.h"

extern int  count_chars(const char *s);
extern void write_newline(int fd);

__attribute__((noreturn))
void error_exit(const char *error_code, const char *error_msg) {
    /* Write out error code */
    int len = count_chars(error_code);
    __asm__ volatile("int $0x80"
                     :
                     : "a"(SYS_WRITE),
                       "b"(STDERR),
                       "c"(error_code),
                       "d"(len));

    /* Write out error message */
    len = count_chars(error_msg);
    __asm__ volatile("int $0x80"
                     :
                     : "a"(SYS_WRITE),
                       "b"(STDERR),
                       "c"(error_msg),
                       "d"(len));

    write_newline(STDERR);

    /* Exit with status 1 */
    __asm__ volatile("int $0x80"
                     :
                     : "a"(SYS_EXIT),
                       "b"(1));
    __builtin_unreachable();
}
