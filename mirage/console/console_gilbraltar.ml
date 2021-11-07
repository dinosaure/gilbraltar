open Lwt.Infix

external serial_rd_ready
  : unit -> bool
  = "gilbraltar_serial_rd_ready" [@@noalloc]
external serial_wr_ready
  : unit -> bool
  = "gilbraltar_serial_wr_ready" [@@noalloc]
external serial_rd_byte
  : unit -> char
  = "gilbraltar_serial_rd" [@@noalloc]
external serial_wr_byte
  : char -> unit
  = "gilbraltar_serial_wr" [@@noalloc]

type t =
  { input : (char, Bigarray.int8_unsigned_elt) Ke.Rke.Weighted.t
  ; output : (char, Bigarray.int8_unsigned_elt) Ke.Rke.Weighted.t }

type error = |
type write_error = [ `Closed ]

let pp_error : Format.formatter -> error -> unit = fun _ppf -> function _ -> .
let pp_write_error ppf `Closed =
  Format.fprintf ppf "Console closed."

(* TODO(dinosaure): even if [kernel.c] initializes correctly UART
 * (because it writes something), we shoud check that we can read
 * and write on this channel - and if it was correctly initialized. *)
let connect () =
  let input, _ = Ke.Rke.Weighted.create ~capacity:0x100 Bigarray.char in
  let output, _ = Ke.Rke.Weighted.create ~capacity:0x100 Bigarray.char in
  Lwt.return { input; output; }

let disconnect _ = Lwt.return_unit

let blit src src_off dst dst_off len =
  let { Cstruct.buffer= dst; off= dst_off; _ } = Cstruct.sub dst dst_off len in
  Bigstringaf.blit src ~src_off dst ~dst_off ~len

let rec read ({ input; _ } as t) buf =
  match Ke.Rke.Weighted.peek input with
  | Some _ ->
    let len = min (Cstruct.length buf) (Ke.Rke.Weighted.length input) in
    Ke.Rke.Weighted.N.keep_exn input buf ~blit ~length:Cstruct.length ~off:0 ~len ;
    Ke.Rke.Weighted.N.shift_exn input len ;
    Lwt.return len
  | None ->
    let rec transmit () = match serial_rd_ready () with
      | false -> Ke.Rke.Weighted.length input
      | true ->
        let chr = serial_rd_byte () in
        match Ke.Rke.Weighted.push input chr with
        | Some () -> transmit ()
        | None -> Ke.Rke.Weighted.length input in
    match transmit () with
    | 0 ->
      OS.Main.wait_for_work_on_handle OS.console_rd >>= fun () ->
      read t buf
    | transmitted ->
      let len = min transmitted (Cstruct.length buf) in
      Ke.Rke.Weighted.N.keep_exn input buf ~blit ~length:Cstruct.length ~off:0 ~len ;
      Ke.Rke.Weighted.N.shift_exn input len ;
      Lwt.return len

let read t =
  let buf = Cstruct.create 0x100 in
  read t buf >>= fun len ->
  Lwt.return_ok (`Data (Cstruct.sub buf 0 len))

let rec drain queue =
  if Ke.Rke.Weighted.is_empty queue
  then Lwt.return_unit
  else match serial_wr_ready () with
    | true ->
      let chr = Ke.Rke.Weighted.pop_exn queue in
      serial_wr_byte chr ; drain queue
    | false ->
      OS.Main.wait_for_work_on_handle OS.console_wr >>= fun () -> drain queue

let blit src src_off dst dst_off len =
  let { Cstruct.buffer= src; off= src_off; _ } = Cstruct.sub src src_off len in
  Bigstringaf.blit src ~src_off dst ~dst_off ~len

let rec write ({ output; _ } as t) ({ Cstruct.len; _ } as buf) =
  match Ke.Rke.Weighted.(available output = length output) with
  | true -> 
    drain output >>= fun () ->
    write t buf
  | false ->
    let len' = min len (Ke.Rke.Weighted.available output) in
    let _    = Ke.Rke.Weighted.N.push_exn output buf
      ~blit ~length:Cstruct.length ~off:0 ~len:len' in
    if len' - len = 0 then Lwt.return_unit
    else write t (Cstruct.shift buf len')

let log t line =
  let cs = Cstruct.create (String.length line + 2) in
  Cstruct.blit_from_string line 0 cs 0 (String.length line) ;
  Cstruct.set_char cs (String.length line) '\r' ;
  Cstruct.set_char cs (String.length line + 1) '\n' ;
  write t cs >>= fun () -> drain t.output

let rec writev t = function
  | [] -> Lwt.return_ok ()
  | x :: r -> write t x >>= fun () -> writev t r

let write t buf = write t buf >>= fun () -> Lwt.return_ok ()

let close _t = Lwt.return_unit
