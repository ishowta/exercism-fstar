module Lemmas.List

module B = Bridge
module UI = FStar.UInt
module L = FStar.List.Pure

val map2_keep_length:
                f: ('a1 -> 'a2 -> Tot 'b)
             -> l1: (list 'a1)
             -> l2: (list 'a2)
             -> Lemma (requires (L.length l1 == L.length l2))
                      (ensures (
                          L.length (L.map2 f l1 l2)) = L.length l1
                          /\ (L.length (L.map2 f l1 l2)) = L.length l2)
                      [SMTPat (L.map2 f l1 l2)]
let rec map2_keep_length f l1 l2 =
    match l1, l2 with
    | [], [] -> ()
    | x1::xs1, x2::xs2 -> map2_keep_length f xs1 xs2

val zip_keep_length:
                l1: (list 'a1)
             -> l2: (list 'a2)
             -> Lemma (requires (L.length l1 == L.length l2))
                      (ensures (
                          L.length (L.zip l1 l2)) = L.length l1
                          /\ (L.length (L.zip l1 l2)) = L.length l2)
                      [SMTPat (L.zip l1 l2)]
let rec zip_keep_length l1 l2 =
    match l1, l2 with
    | [], [] -> ()
    | x1::xs1, x2::xs2 -> zip_keep_length xs1 xs2

val filter_decrease_length:
                f: ('a -> Tot bool)
             -> l: (list 'a)
             -> Lemma (requires True)
                      (ensures L.length (L.filter f l) <= L.length l)
                      [SMTPat (L.filter f l)]
let rec filter_decrease_length f l =
    match l with
    | [] -> ()
    | hd::tl -> filter_decrease_length f tl
