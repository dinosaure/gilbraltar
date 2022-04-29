(* Lightweight thread library for Objective Caml
 * http://www.ocsigen.org/lwt
 * Module Lwt_mirage, based on Lwt_unix
 * Copyright (C) 2021 Romain Calascibetta <romain.calascibetta@gmail.com>
 * Copyright (C) 2010 Anil Madhavapeddy
 * Copyright (C) 2005-2008 Jérôme Vouillon
 * Laboratoire PPS - CNRS Université Paris Diderot
 *                    2009 Jérémie Dimino
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

open Lwt.Infix

type t = int64

type sleep =
  { time : t
  ; mutable canceled : bool
  ; thread : unit Lwt.u }

module Sleeper = struct
  type t = sleep

  let compare { time= t1; _ } { time= t2; _ } = Int64.compare t1 t2
end

module SleepQueue = Binary_heap.Make (Sleeper)

external now
  : unit -> (int64[@unboxed])
  = "gilbraltar_elapsed_us"
    "gilbraltar_elapsed_us_unboxed" [@@noalloc]
(* TODO(dinosaure): again, here we use BCM2711 system timer but
 * the accurrency of it is may be worse than [cntpct_el0]. *)

let sleep_queue =
  let dummy =
    { time = now ()
    ; canceled = false
    ; thread = Lwt.wait () |> snd } in
  SleepQueue.create ~dummy 0

let new_sleeps = ref []

let sleep_us d =
  let (res, w) = Lwt.task () in
  let t = Int64.add (now ()) d in
  let sleeper = { time = t; canceled = false; thread = w } in
  new_sleeps := sleeper :: !new_sleeps ;
  Lwt.on_cancel res (fun _ -> sleeper.canceled <- true) ;
  res

exception Timeout

let timeout d = sleep_us d >>= fun () -> Lwt.fail Timeout

let with_timeout d f = Lwt.pick [timeout d; Lwt.apply f ()]

let in_the_past now t =
  t = 0L || t <= now ()

let rec restart_threads now =
  match SleepQueue.minimum sleep_queue with
  | exception Binary_heap.Empty -> ()
  | { canceled = true; _ } ->
      SleepQueue.remove sleep_queue;
      restart_threads now
  | { time; thread; _ } when in_the_past now time ->
      SleepQueue.remove sleep_queue;
      Lwt.wakeup thread ();
      restart_threads now
  | _ -> ()

let rec get_next_timeout () =
  match SleepQueue.minimum sleep_queue with
  | exception Binary_heap.Empty -> None
  | { canceled = true; _ } ->
      SleepQueue.remove sleep_queue;
      get_next_timeout ()
  | { time; _ } ->
      Some time

let select_next () =
  List.iter (fun e -> SleepQueue.add sleep_queue e) !new_sleeps;
  new_sleeps := [];
  get_next_timeout ()
