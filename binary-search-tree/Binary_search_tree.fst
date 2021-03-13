module Binary_search_tree
open Bridge

open Base

type bst

val empty : bst

val value : bst -> (int, string) Result.t

val left : bst -> (bst, string) Result.t

val right : bst -> (bst, string) Result.t

val insert : native_int -> bst -> bst

val to_list : bst -> native_int list

