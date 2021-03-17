module Nucleotide_count.Base
open Bridge
open List.Lemmas
module List = FStar.List.Pure

let cmp_by_code (lhs:char) (rhs:char) : bool = Char.int_of_char lhs <= Char.int_of_char rhs

let nucleotide_types = OrdSet.Ext.as_ordset #_ #cmp_by_code ['A'; 'C'; 'G'; 'T']

(* Count the number of times a nucleotide occurs in the string. *)
val count_nucleotide: string -> char -> Tot (result int char)
let count_nucleotide data nucleotide =
    match (String.list_of_string data), nucleotide with
    | _, nucleotide when not (OrdSet.mem nucleotide nucleotide_types)
        -> Error nucleotide
    | data, _ when List.existsb (fun elm -> not (OrdSet.mem elm nucleotide_types)) data
        -> Error (List.Ext.find (fun elm -> not (OrdSet.mem elm nucleotide_types)) data)
    | data, nucleotide
        -> Ok (List.count nucleotide data)

(* Count the nucleotides in the string. *)
val count_nucleotides: string -> Tot (result (ordmap char pos cmp_by_code) char)
let count_nucleotides data = match (String.list_of_string data) with
    | data when List.existsb (fun elm -> not (OrdSet.mem elm nucleotide_types)) data
        -> Error (List.Ext.find (fun elm -> not (OrdSet.mem elm nucleotide_types)) data)
    | data
        -> Ok (
            OrdSet.fold #_ #(ordmap char pos cmp_by_code) #_ (
                fun countMap -> fun nucleotide ->
                    match List.count nucleotide data with
                        | 0 -> countMap
                        | count -> OrdMap.update nucleotide count countMap
            ) (OrdMap.empty) nucleotide_types
        )
