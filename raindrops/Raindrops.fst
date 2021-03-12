module Raindrops

open Bridge
module LS = Lemmas.String

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

val raindrop_cause_some_sound: (n:native_int) -> Lemma (raindrop n <> "")
let raindrop_cause_some_sound n =
    LS.empty_string_length_is_zero "";
    match of_int n with
    | n when n % 3 <> 0 && n % 5 <> 0 && n % 7 <> 0 -> ()
    | n -> LS.not_empty_string_length_is_pos "Pling";
            LS.not_empty_string_length_is_pos "Plang";
            LS.not_empty_string_length_is_pos "Plong"
