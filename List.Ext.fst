module List.Ext

(** [find f l] returns [x] such that [f x] holds. *)
val find: #a:Type
        -> f:(a -> Tot bool)
        -> (l:list a{List.existsb f l})
        -> Tot (x:a{f x})
let rec find #a f l = match l with
  | hd::tl -> if f hd then hd else find f tl
