(* Lightweight thread library for Objective Caml
 * http://www.ocsigen.org/lwt
 * Module Lwt_main
 * Copyright (C) 2009 Jérémie Dimino
 * Copyright (C) 2010 Anil Madhavapeddy <anil@recoil.org>
 * Copyright (C) 2021 Romain Calascibetta <romain.calascibetta@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, with linking exceptions;
 * either version 2.1 of the License, or (at your option) any later
 * version. See COPYING file for details.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
 * 02111-1307, USA.
 *)

external yield
  : (Time.t[@unboxed]) -> (int64[@unboxed])
  = "bytecode_unavailable" "gilbraltar_yield"
  [@@noalloc]

module Handle = struct
  type t = int

  let compare a b = compare a b
end

module HandleMap = Map.Make(Handle)

let work = ref HandleMap.empty

let wait_for_work_on_handle h =
  match HandleMap.find h !work with
  | exception Not_found ->
    let cond = Lwt_condition.create () in
    work := HandleMap.add h cond !work;
    Lwt_condition.wait cond
  | cond ->
    Lwt_condition.wait cond

let rec run t = go t
and go t =
  Lwt.wakeup_paused ();
  Time.restart_threads Time.now ;
  match Lwt.poll t with
  | Some () -> ()
  | None ->
    Mirage_runtime.run_enter_iter_hooks () ;
    let timeout = match Time.select_next () with
      | None -> Int64.add (Time.now ()) (Duration.of_day 1)
      | Some tm -> tm in
    let ready_set = yield timeout in
    begin match ready_set with
    | 0L -> ()
    | ready_set ->
      let is_in_set set x = 0L <> Int64.(logand set (shift_left 1L x)) in
      let run k v =
        if is_in_set ready_set k
        then Lwt_condition.broadcast v () in
      HandleMap.iter run !work
    end ;
    Mirage_runtime.run_leave_iter_hooks () ;
    go t

let () =
  at_exit @@ fun () ->
  Lwt.abandon_wakeups () ;
  run (Mirage_runtime.run_exit_hooks ())
