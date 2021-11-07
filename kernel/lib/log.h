typedef enum {
  ERROR=0,
  WARN,
  INFO,
  DEBUG
} log_level_t;

int log(log_level_t level, const char *fmt, ...)
	__attribute__((format (printf, 2, 3)));
int log_actual(log_level_t level, const char *fmt, ...)
	__attribute__((format (printf, 2, 3)));
void log_set_level(log_level_t level);
