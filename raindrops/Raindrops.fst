module Raindrops
open Bridge

(*
    If the number contains 3 as a factor, output 'Pling'.
    If the number contains 5 as a factor, output 'Plang'.
    If the number contains 7 as a factor, output 'Plong'.
    If the number does not contain 3, 5, or 7 as a factor, just pass the number's digits straight through.
*)
val raindrop : native_int -> string
let raindrop n = match of_int n with
    | n when n % 3 <> 0 && n % 5 <> 0 && n % 7 <> 0 -> string_of_int n
    | n -> (if n % 3 = 0 then "Pling" else "")
            ^ (if n % 5 = 0 then "Plang" else "")
            ^ (if n % 7 = 0 then "Plong" else "")

module S = FStar.String

val string_of_int_return_not_empty_string: (n:int) -> Lemma (ensures S.length (string_of_int n) <> 0) [SMTPat (string_of_int n)]
let string_of_int_return_not_empty_string = admit()

val strcat_add_length: (s1:string) -> (s2:string) -> Lemma (ensures (S.length s1) + (S.length s2) = (S.length (s1 ^ s2))) [SMTPat (s1 ^ s2)]
let strcat_add_length = admit()

val empty_string_length_is_zero: (s:string) -> Lemma (requires s = "") (ensures S.length s = 0)
let empty_string_length_is_zero = admit()

val not_empty_string_length_is_pos: (s:string) -> Lemma (requires s <> "") (ensures S.length s > 0)
let not_empty_string_length_is_pos = admit()

val raindrop_return_any_sound: (n:native_int) -> Lemma (ensures S.length (raindrop n) > 0)
let raindrop_return_any_sound n = match of_int n with
    | n when n % 3 <> 0 && n % 5 <> 0 && n % 7 <> 0 -> ()
    | n -> empty_string_length_is_zero "";
            not_empty_string_length_is_pos "Pling";
            not_empty_string_length_is_pos "Plang";
            not_empty_string_length_is_pos "Plong"
