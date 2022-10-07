type addr = nativeint

external dmb : unit -> unit = "gilbraltar_barrier_dmb" [@@noalloc]
external unsafe_set_uint64 : (addr[@unboxed]) -> (int64[@unboxed]) -> unit
  = "gilbraltar_unsafe_set_uint64"
    "gilbraltar_unsafe_set_unboxed_uint64" [@@noalloc]
external unsafe_set_uint32 : (addr[@unboxed]) -> (int32[@unboxed]) -> unit
  = "gilbraltar_unsafe_set_uint32"
    "gilbraltar_unsafe_set_unboxed_uint32" [@@noalloc]

(* XXX(dinosaure): [unsafe_set_int] should **always** be able to set a 63-bits
 * integer into the a `uint64_t *` given address! The main difference with what
 * @dbuenzli did is about the version of the RPi - here we work with RPi4
 * (probably 3) with the 64-bits mode. The compiler used by our
 * [gilbraltar-toolchain] is [gcc-aarch64-linux-gnu]. *)

(* XXX(dinosaure): byte-code version of externals are useless, we should make a
 * trap which should be **never** reached. *)
