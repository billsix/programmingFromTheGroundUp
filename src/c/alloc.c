/* PURPOSE: Manage memory by walking a heap of headered regions
 *          and growing the program break via SYS_BRK when more
 *          space is needed.
 *
 * Each region looks like:
 *
 *   ###########################################
 *   # available marker # size # actual bytes #
 *   ###########################################
 *                              ^-- pointer returned to caller
 *
 * Library file — no _start.  Linked into programs that want a
 * malloc/free pair without depending on libc.
 */

#include "linux.h"

#define HEADER_SIZE       8
#define HDR_AVAIL_OFFSET  0
#define HDR_SIZE_OFFSET   4

#define UNAVAILABLE 0
#define AVAILABLE   1

static unsigned long heap_begin    = 0;
static unsigned long current_break = 0;

/* If brk is called with 0, the kernel returns the last valid
 * usable address.  We bump it by one so we point at the byte
 * after the current break.
 */
void allocate_init(void) {
    unsigned long brk;
    __asm__ volatile("int $0x80"
                     : "=a"(brk)
                     : "a"(SYS_BRK),
                       "b"(0));
    brk++;
    current_break = brk;
    heap_begin    = brk;
}

void *allocate(unsigned size) {
    unsigned long ptr = heap_begin;

    /* Walk existing regions, looking for an available block big
     * enough to hold `size` bytes.
     */
    while (ptr != current_break) {
        unsigned long avail = *(unsigned long *)(ptr + HDR_AVAIL_OFFSET);
        unsigned long rsize = *(unsigned long *)(ptr + HDR_SIZE_OFFSET);

        if (avail == AVAILABLE && size <= rsize) {
            *(unsigned long *)(ptr + HDR_AVAIL_OFFSET) = UNAVAILABLE;
            return (void *)(ptr + HEADER_SIZE);
        }
        ptr += HEADER_SIZE + rsize;
    }

    /* No fit — ask the kernel for more memory. */
    unsigned long new_break = current_break + HEADER_SIZE + size;
    unsigned long ret;
    __asm__ volatile("int $0x80"
                     : "=a"(ret)
                     : "a"(SYS_BRK),
                       "b"(new_break));

    if (ret == 0) {
        return 0;
    }

    *(unsigned long *)(current_break + HDR_AVAIL_OFFSET) = UNAVAILABLE;
    *(unsigned long *)(current_break + HDR_SIZE_OFFSET)  = size;

    void *result  = (void *)(current_break + HEADER_SIZE);
    current_break = new_break;
    return result;
}

/* The caller hands us the pointer they got from allocate(),
 * which sits HEADER_SIZE bytes past the region header.  Step
 * back to the header and flip the availability flag.
 */
void deallocate(void *p) {
    unsigned long ptr = (unsigned long)p - HEADER_SIZE;
    *(unsigned long *)(ptr + HDR_AVAIL_OFFSET) = AVAILABLE;
}
