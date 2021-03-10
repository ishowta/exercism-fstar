module Bridge

exception InvalidInput

assume new type native_int

val of_int: native_int -> Tot Prims.int
