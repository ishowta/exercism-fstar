module Raindrops
open Bridge

module I = FStar.Int

val string_of_int_return_not_empty_string: (n:int) -> Lemma (ensures string_of_int n <> "") [SMTPat (string_of_int n)]

let string_of_int_return_not_empty_string = admit()

(*
    If the number contains 3 as a factor, output 'Pling'.
    If the number contains 5 as a factor, output 'Plang'.
    If the number contains 7 as a factor, output 'Plong'.
    If the number does not contain 3, 5, or 7 as a factor, just pass the number's digits straight through.
*)
val raindrop : native_int -> string
let raindrop n =
    let n = of_int n in
    if n % 3 <> 0 && n % 5 <> 0 && n % 7 <> 0
    then
        string_of_int n
    else
        (if n % 3 = 0 then "Pling" else "")
        ^ (if n % 5 = 0 then "Plang" else "")
        ^ (if n % 7 = 0 then "Plong" else "")
