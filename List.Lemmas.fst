module List.Lemmas

module List = FStar.List.Pure

val map2_keep_length:
                f: ('a1 -> 'a2 -> Tot 'b)
             -> l1: (list 'a1)
             -> l2: (list 'a2)
             -> Lemma (requires (List.length l1 == List.length l2))
                      (ensures (
                          List.length (List.map2 f l1 l2)) = List.length l1
                          /\ (List.length (List.map2 f l1 l2)) = List.length l2)
                      [SMTPat (List.map2 f l1 l2)]
let rec map2_keep_length f l1 l2 =
    match l1, l2 with
    | [], [] -> ()
    | x1::xs1, x2::xs2 -> map2_keep_length f xs1 xs2

val zip_keep_length:
                l1: (list 'a1)
             -> l2: (list 'a2)
             -> Lemma (requires (List.length l1 == List.length l2))
                      (ensures (
                          List.length (List.zip l1 l2)) = List.length l1
                          /\ (List.length (List.zip l1 l2)) = List.length l2)
                      [SMTPat (List.zip l1 l2)]
let rec zip_keep_length l1 l2 =
    match l1, l2 with
    | [], [] -> ()
    | x1::xs1, x2::xs2 -> zip_keep_length xs1 xs2

val filter_decrease_length:
                f: ('a -> Tot bool)
             -> l: (list 'a)
             -> Lemma (requires True)
                      (ensures List.length (List.filter f l) <= List.length l)
                      [SMTPat (List.filter f l)]
let rec filter_decrease_length f l =
    match l with
    | [] -> ()
    | hd::tl -> filter_decrease_length f tl

val count_decrease_length:
                #a:eqtype
             -> x: a
             -> l: (list a)
             -> Lemma (requires True)
                      (ensures List.count x l <= List.length l)
                      [SMTPat (List.count x l)]
let rec count_decrease_length x l =
    match l with
    | [] -> ()
    | hd::tl -> count_decrease_length x tl
