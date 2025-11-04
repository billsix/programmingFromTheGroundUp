// max_glibc.c — Find max value, terminate with syscall(), no stdio

#define _GNU_SOURCE       // enable syscall() prototype
#include <unistd.h>       // for syscall()
#include <sys/syscall.h>  // for __NR_exit
#include <stdint.h>

// Data section
static int data_items[] = {3,  67, 34, 222, 45, 75, 54,
                           34, 44, 33, 22,  11, 66, 0};

int maximum() {
  int i = 0;
  int max = data_items[0];

  while (data_items[i] != 0) {
    if (data_items[i] > max) max = data_items[i];
    i++;
  }
  return max;
}

int main(void) {
  // use glibc's syscall wrapper instead of inline asm
  syscall(__NR_exit, maximum());

  // should never reach here
  return 0;
}
