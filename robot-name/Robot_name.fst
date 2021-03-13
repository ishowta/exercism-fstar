module Robot_name
open Bridge

type robot

val new_robot : unit -> robot

val name : robot -> string

val reset : robot -> unit
