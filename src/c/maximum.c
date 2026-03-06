// max_glibc.c — Find max value, terminate with syscall(), no stdio

// Data section
int data_items[] = {3, 67, 34, 222, 45, 75, 54, 34, 44, 33, 22, 11, 66, 0};

int maximum() {
  int i = 0;
  int max = data_items[0];

  while (data_items[i] != 0) {
    if (data_items[i] > max) max = data_items[i];
    i++;
  }
  return max;
}

__attribute__((noreturn)) void _start(void) {
  int max = maximum();
  __asm__ volatile("int $0x80"
                   :
                   : "a"(1),   // SYS_exit
                     "b"(max)  // Exit code in ebx
  );
  __builtin_unreachable();  // Good practice with noreturn
}
