module Grade_school
open Bridge

(** Grade-school exercise *)
type school

val empty_school :  school

(** Add a student to a school *)
val add : string -> native_int -> school -> school

(** Get all the students from a grade *)
val grade : native_int -> school -> string list

(** Sort the list of students in a grade, if necessary *)
val sorted : school -> school

(** Get all students sorted by grade **)
val roster : school -> string list
