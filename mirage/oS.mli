type handle

module Main : sig
  val wait_for_work_on_handle : handle -> unit Lwt.t
  val run : unit Lwt.t -> unit
end

val console_rd : handle
val console_wr : handle
