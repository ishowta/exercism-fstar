module Word_count
open Bridge

open Base

(**
 * Count occurences of words (consisting of letters and numbers) in the string.
 *
 * Words will be converted to lower case before comparison and insertion in the
 * map.
 *)
val word_count : string -> native_int Map.M(String).t
