module Binary_search
open Bridge

open Base

(* Finds an native_int in an array of ints via binary search *)
val find : native_int array -> native_int -> (int, string) Result.t