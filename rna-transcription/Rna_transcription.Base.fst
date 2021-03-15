module Rna_transcription.Base
open Bridge
module L = FStar.List.Pure

(** Rna-transcription exercise *)

(** Transcribe DNA to RNA by replacing 'T' with 'U'. *)
val to_rna : native_list DNA.dna -> Tot (native_list RNA.rna)
let to_rna l = L.map (fun dna -> match dna with
    | DNA.A -> RNA.U
    | DNA.C -> RNA.G
    | DNA.G -> RNA.C
    | DNA.T -> RNA.A
) l
