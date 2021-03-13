module Dominoes
open Bridge

type dominoe = (int * int)

val chain : dominoe list -> (dominoe list) option