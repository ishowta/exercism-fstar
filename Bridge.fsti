module Bridge

module L = FStar.List.Pure

type result 'a 'b =
| Ok: v: 'a -> result 'a 'b
| Error: e: 'b -> result 'a 'b

val native_int_bits: Prims.pos

assume new type native_int

val of_int: native_int -> Tot (FStar.Int.int_t native_int_bits)

val to_native_int:
    #s:pos
    -> (n:FStar.Int.int_t s{s <= native_int_bits})
    -> Tot (native_n:native_int{of_int native_n = n})

type isize = FStar.Int.int_t native_int_bits
