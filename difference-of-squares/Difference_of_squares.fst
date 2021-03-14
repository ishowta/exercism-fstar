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
    let n = of_int n in
    if 1 <= n && Tot.square_of_sum n <= I.max_int native_int_bits then
        to_native_int (Tot.square_of_sum n)
    else
        raise TooBigInteger

(* Sum the squares of the numbers up to the given number *)
val sum_of_squares : native_int -> Ex native_int
let sum_of_squares n =
    let n = of_int n in
    if 1 <= n && Tot.sum_of_squares n <= I.max_int native_int_bits then
        to_native_int (Tot.sum_of_squares n)
    else
        raise TooBigInteger

(* Subtract sum of squares from square of sums *)
val difference_of_squares : native_int -> Ex native_int
let difference_of_squares n =
    let n = of_int n in
    if 1 <= n && Tot.difference_of_squares n <= I.max_int native_int_bits then
        to_native_int (Tot.difference_of_squares n)
    else
        raise TooBigInteger
