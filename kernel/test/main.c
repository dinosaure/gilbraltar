
// stub
void _nolibc_init() {

}
void uart_write_text(char *buffer);
void uart_drain_output_queue();

void caml_startup(){
    uart_write_text("Hello.\n");
    uart_drain_output_queue();
}