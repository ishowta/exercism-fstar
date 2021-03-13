module Space_age
open Bridge

(** Space-age exercise *)

type planet = Mercury | Venus | Earth | Mars
            | Jupiter | Saturn | Neptune | Uranus

(** Convert seconds to years on the specified planet *)
val age_on : planet -> native_int -> float
