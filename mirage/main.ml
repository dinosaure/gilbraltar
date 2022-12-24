(* Lightweight thread library for Objective Caml
 * http://www.ocsigen.org/lwt
 * Module Lwt_main
 * Copyright (C) 2009 Jérémie Dimino
 * Copyright (C) 2010 Anil Madhavapeddy <anil@recoil.org>
 * Copyright (C) 2021 Romain Calascibetta <romain.calascibetta@gmail.com>
 * Copyright (C) 2022 Lucas Pluvinage
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

external wait_for_interrupt : unit -> unit = "wfi"
(* TODO(dinosaure): check that! *)

let do_something_useless () = ignore @@ Bytes.create 1
(* XXX(dinosaure): just to be sure that signals are properly
 * handled by the caml runtime. *)

let rec go t =
  Lwt.wakeup_paused ();
  Time.restart_threads Time.now ;
  match Lwt.poll t with
  | Some () -> ()
  | None ->
    Mirage_runtime.run_enter_iter_hooks () ; (* TODO(dinosaure): before or after [Lwt.poll]? *)
    let timeout =
      if Lwt.paused_count () > 0
      then 0L
      else match Time.select_next () with
      | None -> Int64.add (Interrupts.elapsed_us ()) (Duration.of_day 1)
      | Some tm -> tm in
    Interrupts.(schedule L1) timeout ;
    wait_for_interrupt () ;
    do_something_useless () ;
    Mirage_runtime.run_leave_iter_hooks () ;
    go t

external irq_enable : unit -> unit = "irq_enable"
(* XXX(dinosaure): provided by the gi(l)braltar kernel. We should check what we emit! *)

let timer_interrupt_handler _ =
  Interrupts.acknowledge L1 ;
  Mem.dmb () ;
  irq_enable () ;
;;

let run t =
  Sys.set_signal Interrupts.(line_to_signal_number L1)
    (Sys.Signal_handle timer_interrupt_handler) ;
  go t

let () =
  at_exit @@ fun () ->
  Lwt.abandon_wakeups () ;
  go (Mirage_runtime.run_exit_hooks ())
