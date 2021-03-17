module OrdSet.Ext
module List = FStar.List.Pure
open FStar.OrdSet

// TODO: Change to lemma of OrdSet.fold (or OrdSetProps.fold ?)
val fold: #a:eqtype -> #b:Type -> #f:cmp a -> s:ordset a f -> ((key:a{mem key s}) -> b -> Tot b) -> b
          -> Tot b (decreases (size s))
let rec fold (#a:eqtype) (#b:Type) #f s g x =
  if s = empty then x
  else
    let Some e = choose s in
    let a_rest = fold (remove e s) g x in
    g e a_rest

val insert: #a:eqtype -> #f:cmp a -> a -> ordset a f -> ordset a f
let insert #_ #_ x s = union s (singleton x)

val as_ordset: #a:eqtype -> #f:cmp a -> list a -> ordset a f
let as_ordset #a #f l =
    List.fold_left (fun acc -> fun x -> insert x acc) empty l
