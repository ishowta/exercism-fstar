module Lemmas.String

module S = FStar.String

val string_of_int_return_not_empty_string: (n:int) -> Lemma (ensures S.length (string_of_int n) > 0 /\ (string_of_int n) <> "") [SMTPat (string_of_int n)]

val strcat_add_length: (s1:string) -> (s2:string) -> Lemma (ensures (S.length s1) + (S.length s2) = (S.length (s1 ^ s2))) [SMTPat (s1 ^ s2)]

val string_length_is_nat: (s:string) -> Lemma (S.length s >= 0)

val empty_string_length_is_zero: (s:string) -> Lemma (requires s = "") (ensures S.length s = 0)

val zero_length_string_is_empty: (s:string) -> Lemma (requires S.length s = 0) (ensures s = "")

val not_empty_string_length_is_pos: (s:string) -> Lemma (requires s <> "") (ensures S.length s > 0)

val pos_length_string_is_not_empty: (s:string) -> Lemma (requires S.length s > 0) (ensures s <> "")
