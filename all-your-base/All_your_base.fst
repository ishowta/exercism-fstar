module All_your_base
open Bridge

type base = int

val convert_bases : from: base -> digits: native_int list -> target: base -> (int list) option
