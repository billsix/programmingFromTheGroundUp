/* Common Linux Definitions
 *
 * C equivalent of linux.s — system call numbers, the syscall
 * interrupt vector, and standard file descriptor constants.
 */

#ifndef LINUX_H
#define LINUX_H

/* System Call Numbers */
#define SYS_EXIT  1
#define SYS_READ  3
#define SYS_WRITE 4
#define SYS_OPEN  5
#define SYS_CLOSE 6
#define SYS_BRK   45

/* System Call Interrupt Number */
#define LINUX_SYSCALL 0x80

/* Standard File Descriptors */
#define STDIN  0
#define STDOUT 1
#define STDERR 2

/* Common Status Codes */
#define END_OF_FILE 0

#endif
