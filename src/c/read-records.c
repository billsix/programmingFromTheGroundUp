/* PURPOSE: Open test.dat, read records one by one, and print
 *          each record's first name to STDOUT followed by a
 *          newline.  Stops when read_record returns less than
 *          a full record (EOF).
 *
 * Links against: read-record.c, count-chars.c, write-newline.c.
 */

#include "linux.h"
#include "record-def.h"

extern int  read_record(int fd, void *buffer);
extern int  count_chars(const char *s);
extern void write_newline(int fd);

static struct record record_buffer;

__attribute__((noreturn)) void _start(void) {
    static const char file_name[] = "test.dat";
    int fd_in;
    int fd_out = STDOUT;

    /* Open the data file (read-only — flags = 0) */
    __asm__ volatile("int $0x80"
                     : "=a"(fd_in)
                     : "a"(SYS_OPEN),
                       "b"(file_name),
                       "c"(0),
                       "d"(0666));

    while (1) {
        int n = read_record(fd_in, &record_buffer);
        if (n != RECORD_SIZE) {
            break;
        }

        /* Print the first name (offset 0 in the record) */
        int len = count_chars(record_buffer.firstname);
        __asm__ volatile("int $0x80"
                         :
                         : "a"(SYS_WRITE),
                           "b"(fd_out),
                           "c"(record_buffer.firstname),
                           "d"(len));

        write_newline(fd_out);
    }

    __asm__ volatile("int $0x80"
                     :
                     : "a"(SYS_EXIT),
                       "b"(0));
    __builtin_unreachable();
}
