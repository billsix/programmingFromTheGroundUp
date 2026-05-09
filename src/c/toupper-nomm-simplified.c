/* PURPOSE: Read an input file, convert lower-case ASCII letters
 *          to upper-case, and write the result to an output file.
 *
 * USAGE:   ./toupper-nomm-simplified <input> <output>
 *
 * The kernel hands _start the argv vector on the stack with no
 * preceding return address, so the standard C calling convention
 * for main() doesn't apply.  We use a small asm shim as our crt0:
 * read argc/argv off the stack, push them, call my_main, then
 * use my_main's return value as the exit status.
 */

#include "linux.h"

#define O_RDONLY              0
#define O_CREAT_WRONLY_TRUNC  03101
#define BUFFER_SIZE           500

#define LOWERCASE_A 'a'
#define LOWERCASE_Z 'z'
#define UPPER_CONVERSION ('A' - 'a')

__asm__(
    ".global _start\n"
    "_start:\n"
    "    movl  (%esp), %eax\n"     /* argc                 */
    "    leal  4(%esp), %edx\n"    /* argv                 */
    "    pushl %edx\n"
    "    pushl %eax\n"
    "    call  my_main\n"
    "    movl  %eax, %ebx\n"       /* return value -> exit */
    "    movl  $1, %eax\n"
    "    int   $0x80\n"
);

static char BUFFER_DATA[BUFFER_SIZE];

static void convert_to_upper(char *buf, int len) {
    for (int i = 0; i < len; i++) {
        if (buf[i] >= LOWERCASE_A && buf[i] <= LOWERCASE_Z) {
            buf[i] += UPPER_CONVERSION;
        }
    }
}

int my_main(int argc, char **argv) {
    int fd_in, fd_out;

    /* Open input file (read-only) */
    __asm__ volatile("int $0x80"
                     : "=a"(fd_in)
                     : "a"(SYS_OPEN),
                       "b"(argv[1]),
                       "c"(O_RDONLY),
                       "d"(0666));

    /* Open output file (create + write + truncate) */
    __asm__ volatile("int $0x80"
                     : "=a"(fd_out)
                     : "a"(SYS_OPEN),
                       "b"(argv[2]),
                       "c"(O_CREAT_WRONLY_TRUNC),
                       "d"(0666));

    /* read -> convert -> write loop */
    while (1) {
        int n;
        __asm__ volatile("int $0x80"
                         : "=a"(n)
                         : "a"(SYS_READ),
                           "b"(fd_in),
                           "c"(BUFFER_DATA),
                           "d"(BUFFER_SIZE));
        if (n <= END_OF_FILE) {
            break;
        }

        convert_to_upper(BUFFER_DATA, n);

        __asm__ volatile("int $0x80"
                         :
                         : "a"(SYS_WRITE),
                           "b"(fd_out),
                           "c"(BUFFER_DATA),
                           "d"(n));
    }

    /* Close both files */
    __asm__ volatile("int $0x80" : : "a"(SYS_CLOSE), "b"(fd_out));
    __asm__ volatile("int $0x80" : : "a"(SYS_CLOSE), "b"(fd_in));

    return 0;
}
