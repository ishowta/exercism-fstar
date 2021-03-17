module Nucleotide_count
open Bridge
open List.Lemmas
module Base = Nucleotide_count.Base

(* Count the number of times a nucleotide occurs in the string. *)
val count_nucleotide: native_string -> native_char
    -> Tot (result native_int native_char)
let count_nucleotide data nucleotide =
    match Base.count_nucleotide data nucleotide with
    | Ok count -> Ok (to_native_int count)
    | Error c -> Error c

(* Count the nucleotides in the string. *)
val count_nucleotides: native_string
    -> Tot (result (native_map native_char native_int) native_char)
let count_nucleotides data =
    match Base.count_nucleotides data with
    | Ok countMap -> Ok (to_native_map (
        OrdSet.Ext.fold (OrdMap.dom countMap) (
            fun key -> fun acc ->
            (OrdMap.update key (
                assert (forall k. (
                    match OrdMap.select k (OrdMap.empty #char #pos #Base.cmp_by_code) with
                        | None -> True
                ));
                assert (forall k1 k2 m new_v. (
                (
                    match OrdMap.select #_ #_ #Base.cmp_by_code k1 m with
                    | None -> True
                    | Some count -> 0 < count /\ count <= Int.max_int native_int_bits
                ) /\ 0 < new_v /\ new_v <= Int.max_int native_int_bits
                ==>
                (
                    match OrdMap.select k2 (OrdMap.update k1 new_v m) with
                        | None -> True
                        | Some count -> 0 < count /\ count <= Int.max_int native_int_bits
                )));
                assert (forall k. (
                    match Base.count_nucleotides data with
                        | Error _ -> True
                        | Ok data -> (
                            match OrdMap.select k data with
                                | None -> True
                                | Some count -> 0 < count /\ count <= Int.max_int native_int_bits
                        )
                ));
                match OrdMap.select key countMap with
                    | Some count -> to_native_int count
            ) acc)
        ) (OrdMap.empty #_ #_ #Base.cmp_by_code)
    ))
    | Error c -> Error c
