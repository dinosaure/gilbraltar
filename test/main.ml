external setup_handler_1 : unit -> unit = "caml_setup_handler_1"
external setup_handler_3 : unit -> unit = "caml_setup_handler_3"
external ack_interrupt_1 : unit -> unit = "caml_ack_interrupt_1"
external ack_interrupt_3 : unit -> unit = "caml_ack_interrupt_3"

external irq_enable : unit -> unit = "irq_enable"

external wfi : unit -> unit = "wfi"

let handler_irq_1 _ = 
  print_endline "interruption 1";
  ack_interrupt_1 ();
  setup_handler_1 ();
  irq_enable ()

let handler_irq_3 _ =
  print_endline "interruption 3";
  ack_interrupt_3 ();
  setup_handler_3 ();
  irq_enable ()

let () =
  Sys.(set_signal 1 (Signal_handle handler_irq_1)) ;
  Sys.(set_signal 3 (Signal_handle handler_irq_3)) ;
  setup_handler_1 ();
  setup_handler_3 ();
  print_endline "Hello World from OCaml!";
  irq_enable ();
  while true do 
    let _ = Bytes.create 20 in
    ()
  done
