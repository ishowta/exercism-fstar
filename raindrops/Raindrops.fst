module Raindrops

open Bridge

(*
    If the number contains 3 as a factor, output 'Pling'.
    If the number contains 5 as a factor, output 'Plang'.
    If the number contains 7 as a factor, output 'Plong'.
    If the number does not contain 3, 5, or 7 as a factor, just pass the number's digits straight through.
*)
val raindrop : (drop:native_int) -> Tot (sound:string{sound <> ""})
let raindrop drop = match of_int drop with
    | drop when drop % 3 <> 0 && drop % 5 <> 0 && drop % 7 <> 0 -> string_of_int drop
    | drop -> (
        let sound = (if drop % 3 = 0 then "Pling" else "")
            ^ (if drop % 5 = 0 then "Plang" else "")
            ^ (if drop % 7 = 0 then "Plong" else "") in
        Lemmas.String.pos_length_string_is_not_empty sound;
        sound
    )
