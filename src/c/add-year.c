/* PURPOSE: Read every record from test.dat, increment the age
 *          field, and write the modified record to testout.dat.
 *
 * Links against: read-record.c, write-record.c.
 */

#include "linux.h"
#include "record-def.h"

extern int read_record(int fd, void *buffer);
extern int write_record(int fd, const void *buffer);

#define O_CREAT_WRONLY 0101

static struct record record_buffer;

__attribute__((noreturn)) void _start(void) {
    static const char input_file_name[]  = "test.dat";
    static const char output_file_name[] = "testout.dat";
    int fd_in, fd_out;

    /* Open input (read-only) */
    __asm__ volatile("int $0x80"
                     : "=a"(fd_in)
                     : "a"(SYS_OPEN),
                       "b"(input_file_name),
                       "c"(0),
                       "d"(0666));

    /* Open output (create + write) */
    __asm__ volatile("int $0x80"
                     : "=a"(fd_out)
                     : "a"(SYS_OPEN),
                       "b"(output_file_name),
                       "c"(O_CREAT_WRONLY),
                       "d"(0666));

    while (1) {
        int n = read_record(fd_in, &record_buffer);
        if (n != RECORD_SIZE) {
            break;
        }

        record_buffer.age++;

        write_record(fd_out, &record_buffer);
    }

    __asm__ volatile("int $0x80"
                     :
                     : "a"(SYS_EXIT),
                       "b"(0));
    __builtin_unreachable();
}
