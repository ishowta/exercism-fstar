module Leap
open Bridge

val leap_year: native_int -> Tot bool
let leap_year year =
    let year = (of_int year) in
        match year with
        | year when year % 400 = 0 -> true
        | year when year % 100 = 0 -> false
        | year when year % 4 = 0 -> true
        | _ -> false
