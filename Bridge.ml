type ('ok , 'error) result = ('ok , 'error) Base.result =
  | Ok of 'ok
  | Error of 'error

let native_int_bits = Z.of_int (Sys.int_size + 1)

type native_int = int

type isize = Z.t

let of_int = Z.of_int

let to_native_int _ = Z.to_int
