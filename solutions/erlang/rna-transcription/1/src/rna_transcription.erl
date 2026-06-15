-module(rna_transcription).

-export([to_rna/1]).


to_rna(Strand) -> [complement(Nucleotide) || Nucleotide <- Strand].

complement($G) -> $C;
complement($C) -> $G;
complement($T) -> $A;
complement($A) -> $U.