module Difference_of_squares.Tot
open FStar.Mul
module I = FStar.Int

(* Square the sum of the numbers up to the given number *)
val square_of_sum : int -> Tot int
let square_of_sum n = (n * (n + 1)) / 2

(* Sum the squares of the numbers up to the given number *)
val sum_of_squares : int -> Tot int
let sum_of_squares n = (n * (n + 1) * (2 * n + 1)) / 6

(* Subtract sum of squares from square of sums *)
val difference_of_squares : int -> Tot int
let difference_of_squares n = sum_of_squares n - square_of_sum n
