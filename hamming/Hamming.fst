module Hamming

open Bridge
open Lemmas.List
module UI = FStar.Int
module L = FStar.List.Pure

type nucleotide = | A | C | G | T

(** Compute the hamming distance between the two lists. *)
val hamming_distance : (l1: native_list nucleotide) -> (l2: native_list nucleotide) -> Tot (res: result native_int string{
        match res with
            | Ok distance -> L.length l1 = L.length l2
                            /\ 0 <= of_int distance /\ of_int distance <= L.length l1
            | Error msg -> msg = "left strand must not be empty"
                        \/ msg = "right strand must not be empty"
                        \/ msg = "left and right strands must be of equal length"
    })
let hamming_distance l1 l2 = match l1, l2 with
    | l1, l2 when L.length l1 <> L.length l2 && L.length l1 = 0  -> Error "left strand must not be empty"
    | l1, l2 when L.length l1 <> L.length l2 && L.length l2 = 0 -> Error "right strand must not be empty"
    | l1, l2 when L.length l1 <> L.length l2 -> Error "left and right strands must be of equal length"
    | l1, l2 -> Ok (to_native_int #native_int_bits (L.length (L.filter (fun (e1, e2) -> e1 <> e2) (L.zip l1 l2))))
