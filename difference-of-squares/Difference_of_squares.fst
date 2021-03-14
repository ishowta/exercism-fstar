module Difference_of_squares
open Bridge
open FStar.Mul
open FStar.Exn
module Tot = Difference_of_squares.Tot
module I = FStar.Int

exception TooBigInteger

(* Square the sum of the numbers up to the given number *)
val square_of_sum : native_int -> Ex native_int
let square_of_sum n =
    let nf = of_int n in
    if nf < 1 || ((nf * (nf + 1)) / 2) > (I.max_int native_int_bits) then
        raise TooBigInteger
    else
        Tot.square_of_sum n

(* Sum the squares of the numbers up to the given number *)
val sum_of_squares : native_int -> Ex native_int

(* Subtract sum of squares from square of sums *)
val difference_of_squares : native_int -> Ex native_int
