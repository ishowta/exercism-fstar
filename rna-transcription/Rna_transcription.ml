(** Rna-transcription exercise *)

type dna = [ `A | `C | `G | `T ]
type rna = [ `A | `C | `G | `U ]

(** Transcribe DNA to RNA by replacing 'T' with 'U'. *)
let to_rna (l: dna list): rna list =
    l
    |> List.map (fun dna -> match dna with
        | `A -> DNA.A
        | `C -> DNA.C
        | `G -> DNA.G
        | `T -> DNA.T
    )
    |> Rna_transcription_Base.to_rna
    |> List.map (fun rna -> match rna with
        | RNA.A -> `A
        | RNA.C -> `C
        | RNA.G -> `G
        | RNA.U -> `U
    )
