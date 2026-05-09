/* PURPOSE: Write one record to the given file descriptor from
 *          the supplied buffer.
 *
 * INPUT:   fd     - open output file descriptor
 *          buffer - source, at least RECORD_SIZE bytes
 *
 * OUTPUT:  Returns the number of bytes written.
 *
 * Library file — no _start.
 */

#include "linux.h"
#include "record-def.h"

int write_record(int fd, const void *buffer) {
    int ret;
    __asm__ volatile("int $0x80"
                     : "=a"(ret)
                     : "a"(SYS_WRITE),
                       "b"(fd),
                       "c"(buffer),
                       "d"(RECORD_SIZE));
    return ret;
}
