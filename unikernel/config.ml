open Mirage

let main = main "Unikernel.Make" (console @-> job)

let () = register
  ~reporter:no_reporter
  ~argv:no_argv
  "hello" [ main $ default_console ]
