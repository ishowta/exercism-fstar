module Raindrops
open Bridge

module I = FStar.Int
module S = FStar.String

val string_of_int_return_not_empty_string: (n:int) -> Lemma (ensures S.length (string_of_int n) <> 0) [SMTPat (string_of_int n)]
let string_of_int_return_not_empty_string = admit()

val strcat_add_length: (s1:string) -> (s2:string) -> Lemma (ensures (S.length s1) + (S.length s2) = (S.length (s1 ^ s2))) [SMTPat (s1 ^ s2)]
let strcat_add_length = admit()

// TODO: I don't know how to prove a literal
val literal_to_string: string -> string
let literal_to_string s = s

val empty_string_length_is_zero: (s:string) -> Lemma (requires s = "") (ensures S.length (literal_to_string s) = 0) [SMTPat (literal_to_string s)]
let empty_string_length_is_zero = admit()

val not_empty_string_length_is_pos: (s:string) -> Lemma (requires s <> "") (ensures S.length (literal_to_string s) > 0) [SMTPat (literal_to_string s)]
let not_empty_string_length_is_pos = admit()

(*
    If the number contains 3 as a factor, output 'Pling'.
    If the number contains 5 as a factor, output 'Plang'.
    If the number contains 7 as a factor, output 'Plong'.
    If the number does not contain 3, 5, or 7 as a factor, just pass the number's digits straight through.
*)
val raindrop : native_int -> (sound:string{S.length sound > 0})
let raindrop n =
    let n = of_int n in
    if n % 3 <> 0 && n % 5 <> 0 && n % 7 <> 0
    then
        string_of_int n
    else
        (if n % 3 = 0 then literal_to_string "Pling" else literal_to_string "")
        ^ (if n % 5 = 0 then literal_to_string "Plang" else literal_to_string "")
        ^ (if n % 7 = 0 then literal_to_string "Plong" else literal_to_string "")
