module Bridge

module I = FStar.Int
module L = FStar.List.Pure

type result 'a 'b =
| Ok: v: 'a -> result 'a 'b
| Error: e: 'b -> result 'a 'b

val native_int_bits: Prims.pos

assume new type native_int

type isize = I.int_t native_int_bits

val of_int: native_int -> Tot isize

val to_native_int:
    #s:pos
    -> (n:I.int_t s{s <= native_int_bits})
    -> Tot (native_n:native_int{of_int native_n = n})
