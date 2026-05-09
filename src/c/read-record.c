/* PURPOSE: Read one record from the given file descriptor into
 *          the supplied buffer.
 *
 * INPUT:   fd     - open input file descriptor
 *          buffer - destination, at least RECORD_SIZE bytes
 *
 * OUTPUT:  Returns the number of bytes read (or a negative
 *          errno-style value).  A short read indicates EOF.
 *
 * Library file — no _start.
 */

#include "linux.h"
#include "record-def.h"

int read_record(int fd, void *buffer) {
    int ret;
    __asm__ volatile("int $0x80"
                     : "=a"(ret)
                     : "a"(SYS_READ),
                       "b"(fd),
                       "c"(buffer),
                       "d"(RECORD_SIZE));
    return ret;
}
