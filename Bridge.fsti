module Bridge

exception UnReachableError

type result 'a 'b =
| Ok: v: 'a -> result 'a 'b
| Error: e: 'b -> result 'a 'b

val native_int_bits: Prims.pos
val native_uint_bits: Prims.pos

assume new type native_int

type isize = Int.int_t native_int_bits

val of_int: native_int -> Tot isize

val to_native_int:
    (n:Int.int_t native_int_bits)
    -> Tot (native_n:native_int{of_int native_n = n})

type native_list 'a = (l:list 'a{List.length l <= Int.max_int native_int_bits})

type char = FStar.Char.char
type ordmap = FStar.OrdMap.ordmap

type native_string = (s:string{List.length (String.list_of_string s) <= Int.max_int native_int_bits})

type native_char = char

assume new type native_map 'k 'v

val empty_native_map: #k:eqtype -> #v:Type -> unit -> Tot (native_map k v)
val append_native_map: #k:eqtype -> #v:Type -> native_map k v -> k -> v -> Tot (native_map k v)

val dom_select: #k:eqtype -> #v:Type -> #f:OrdMap.cmp k
    -> (key:k) -> (m:ordmap k v f)
    -> Lemma
        (requires OrdSet.mem key (OrdMap.dom m))
        (ensures Some? (OrdMap.select key m))

let to_native_map (#k:eqtype) (#v:Type) #f (m:ordmap k v f): Tot (native_map k v) =
    OrdSet.Ext.fold (OrdMap.dom m) (
        fun key -> fun acc ->
        (append_native_map #k #v acc key (
            match OrdMap.select key m with
                | Some value -> value
        ))
    ) (empty_native_map #k #v ())
