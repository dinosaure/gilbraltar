
typedef enum {
  ERROR=0,
  WARN,
  INFO,
  DEBUG
} log_level_t;

int log(log_level_t level, const char *fmt, ...)
	__attribute__((format (printf, 2, 3)));

// stub
void _nolibc_init() {

}
void uart_write_text(char *buffer);
void uart_drain_output_queue();


long mclock(void);

void caml_startup(){
    uart_write_text("Hello.\n");
    uart_drain_output_queue();

    long clock = mclock();


    int data[0x1000000];

    for (int i = 0; i < 0x1000000; i++) {
        data[i] = i;
    }

    int sum = 0;

    for (int i = 0; i < 0x1000000; i++) {
        if (i % 10000 == 0) {
            sum += data[i];
        } 
    }

    log(INFO, "End. %d ms\n", ((mclock() - clock)) / 1000000);
    uart_drain_output_queue();

}