type line =
  | L0 | L1 | L2 | L3

let line_to_signal_number = function
  | L0 -> 0
  | L1 -> 1
  | L2 -> 2
  | L3 -> 3

let ( + ) = Nativeint.add

let base = 0xfe000000n (* RPi4 only! *)
let mtime = base + 0x003000n
let timer_compare_0 = mtime + 0x0cn
let timer_compare_1 = mtime + 0x10n
let timer_compare_2 = mtime + 0x14n
let timer_compare_3 = mtime + 0x18n

external elapsed_us
  : unit -> (int64[@unboxed])
  = "gilbraltar_elapsed_us"
    "gilbraltar_elapsed_us_unboxed" [@@noalloc]

external sleep_us
  : (int64[@unboxed]) -> unit
  = "gilbraltar_sleep_us"
    "gilbraltar_sleep_us_unboxed" [@@noalloc]

let schedule line target =
  let timer_compare = match line with
    | L0 -> timer_compare_0
    | L1 -> timer_compare_1
    | L2 -> timer_compare_2
    | L3 -> timer_compare_3 in
  Mem.unsafe_set_uint64 timer_compare target

let acknowledge line =
  let cs = match line with
    | L0 -> 0b0001l
    | L1 -> 0b0010l
    | L2 -> 0b0100l
    | L3 -> 0b1000l in
  Mem.unsafe_set_uint32 mtime cs
