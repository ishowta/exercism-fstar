module Lemmas.String

module S = FStar.String

val string_of_int_return_not_empty_string: (n:int) -> Lemma (ensures S.length (string_of_int n) > 0) [SMTPat (string_of_int n)]
let string_of_int_return_not_empty_string = admit()

val strcat_add_length: (s1:string) -> (s2:string) -> Lemma (ensures (S.length s1) + (S.length s2) = (S.length (s1 ^ s2))) [SMTPat (s1 ^ s2)]
let strcat_add_length = admit()

val string_length_is_nat: (s:string) -> Lemma (S.length s >= 0)
let string_length_is_nat = admit()

val empty_string_length_is_zero: (s:string) -> Lemma (requires s = "") (ensures S.length s = 0)
let empty_string_length_is_zero = admit()

val not_empty_string_length_is_pos: (s:string) -> Lemma (requires s <> "") (ensures S.length s > 0)
let not_empty_string_length_is_pos = admit()
