module String.Lemmas
open FStar.String

assume val string_of_int_return_not_empty_string: (n:int) -> Lemma (ensures string_of_int n <> "") [SMTPat (string_of_int n)]

assume val strcat_add_length: (s1:string) -> (s2:string) -> Lemma (ensures (length s1) + (length s2) = (length (s1 ^ s2))) [SMTPat (s1 ^ s2)]

assume val strcat_empty_equal_1: (s:string) -> Lemma (ensures s ^ "" = s) [SMTPat (s ^ "")]

assume val strcat_empty_equal_2: (s:string) -> Lemma (ensures "" ^ s = s) [SMTPat ("" ^ s)]

assume val string_length_is_nat: (s:string) -> Lemma (length s >= 0) [SMTPat (length s)]

assume val empty_string_length_is_zero: (s:string) -> Lemma (requires s = "") (ensures length s = 0)

assume val zero_length_string_is_empty: (s:string) -> Lemma (requires length s = 0) (ensures s = "") [SMTPat (length s)]

assume val not_empty_string_length_is_pos: (s:string) -> Lemma (requires s <> "") (ensures length s > 0)

assume val pos_length_string_is_not_empty: (s:string) -> Lemma (requires length s > 0) (ensures s <> "") [SMTPat (length s)]
