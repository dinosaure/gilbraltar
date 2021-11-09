module Make (Console : Mirage_console.S) = struct
  let log console fmt = Fmt.kstr (fun str -> Console.log console str) fmt

  let start console =
    log console "Hello World from MirageOS!"
end
