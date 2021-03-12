type ('ok , 'error) result = ('ok , 'error) Base.result =
  | Ok of 'ok
  | Error of 'error

(* OCaml doesn't have official unsined int. *)
let native_int_bits = Z.of_int (Sys.int_size + 1)
let native_uint_bits = Z.of_int Sys.int_size

type native_int = int
type native_uint = int

type isize = Z.t
type usize = Z.t

let of_int = Z.of_int
let of_uint = Z.of_int

let to_native_int _ = Z.to_int
let to_native_uint _ = Z.to_int
