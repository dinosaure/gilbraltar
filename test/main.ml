external setup_handler : unit -> unit = "caml_setup_handler"

external irq_enable : unit -> unit = "irq_enable"

let () =
  Sys.(set_signal 2 (Signal_handle (fun _ -> print_endline "interruption"))) ;
  setup_handler ();
  print_endline "Hello World from OCaml!";
  irq_enable ();
  while true do 
    let _ = Bytes.create 20 in
    ()
  done
