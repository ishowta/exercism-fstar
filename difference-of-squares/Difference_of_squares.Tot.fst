module Difference_of_squares.Tot
open Bridge
open FStar.Mul
module I = FStar.Int

(* Square the sum of the numbers up to the given number *)
val square_of_sum : (n:native_int{
    let n = of_int n in
    n >= 1 /\
    ((n * (n + 1)) / 2) <= (I.max_int native_int_bits)
}) -> Tot native_int
let square_of_sum n =
    let n = of_int n in
    let res = (n * (n + 1)) / 2 in
    to_native_int #native_int_bits res

(* Sum the squares of the numbers up to the given number *)
val sum_of_squares : native_int -> Tot native_int

(* Subtract sum of squares from square of sums *)
val difference_of_squares : native_int -> Tot native_int
