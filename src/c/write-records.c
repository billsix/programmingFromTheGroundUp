/* PURPOSE: Create test.dat and write three fixed records to it.
 *
 * The asm version pads each .ascii field to the right size by
 * hand with .rept/.byte 0.  In C, designated initializers do
 * the same job: any unspecified bytes in a fixed-size char
 * array are zero-filled, which both null-terminates the string
 * and pads to the field width.
 *
 * Links against: write-record.c.
 */

#include "linux.h"
#include "record-def.h"

extern int write_record(int fd, const void *buffer);

#define O_CREAT_WRONLY 0101

static const struct record records[3] = {
    {
        .firstname = "Fredrick",
        .lastname  = "Bartlett",
        .address   = "4242 S Prairie\nTulsa, OK 55555",
        .age       = 45,
    },
    {
        .firstname = "Marilyn",
        .lastname  = "Taylor",
        .address   = "2224 S Johannan St\nChicago, IL 12345",
        .age       = 29,
    },
    {
        .firstname = "Derrick",
        .lastname  = "McIntire",
        .address   = "500 W Oakland\nSan Diego, CA 54321",
        .age       = 36,
    },
};

__attribute__((noreturn)) void _start(void) {
    static const char file_name[] = "test.dat";
    int fd;

    /* Open the file: create if missing, open for writing */
    __asm__ volatile("int $0x80"
                     : "=a"(fd)
                     : "a"(SYS_OPEN),
                       "b"(file_name),
                       "c"(O_CREAT_WRONLY),
                       "d"(0666));

    for (int i = 0; i < 3; i++) {
        write_record(fd, &records[i]);
    }

    __asm__ volatile("int $0x80"
                     :
                     : "a"(SYS_CLOSE),
                       "b"(fd));

    __asm__ volatile("int $0x80"
                     :
                     : "a"(SYS_EXIT),
                       "b"(0));
    __builtin_unreachable();
}
