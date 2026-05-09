/* PURPOSE: Given a number, compute its factorial.  4! = 24.
 *
 * Demonstrates a recursive function call.  The exit status is
 * the result, so `./factorial; echo $?` prints 24.
 */

#include "linux.h"

int factorial(int n) {
    if (n == 1) {
        return 1;
    }
    return n * factorial(n - 1);
}

__attribute__((noreturn)) void _start(void) {
    int result = factorial(4);

    __asm__ volatile("int $0x80"
                     :
                     : "a"(SYS_EXIT),
                       "b"(result));
    __builtin_unreachable();
}
