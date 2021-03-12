module Bridge

module I = FStar.Int
module UI = FStar.UInt
module L = FStar.List.Pure

type result 'a 'b =
| Ok: v: 'a -> result 'a 'b
| Error: e: 'b -> result 'a 'b

val native_int_bits: Prims.pos
val native_uint_bits: Prims.pos

assume new type native_int
assume new type native_uint

type isize = I.int_t native_int_bits
type usize = UI.uint_t native_uint_bits

val of_int: native_int -> Tot isize
val of_uint: native_uint -> Tot usize

val to_native_int:
    #s:pos
    -> (n:I.int_t s{s <= native_int_bits})
    -> Tot (native_n:native_int{of_int native_n = n})
val to_native_uint:
    #s:pos
    -> (n:UI.uint_t s{s <= native_uint_bits})
    -> Tot (native_n:native_uint{of_uint native_n = n})
