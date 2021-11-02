void _assert_fail(const char *, const char *, const char *)
    __attribute__((noreturn));
void _abort(const char *, const char *, const char *, void *)
    __attribute__((noreturn));

#define PANIC(s, r)                            \
    do {                                       \
        _abort(__FILE__, STR(__LINE__), s, r); \
    } while (0)

#define assert(e)                                      \
    do {                                               \
        if (!(e))                                      \
            _assert_fail(__FILE__, STR(__LINE__), #e); \
    } while (0)
