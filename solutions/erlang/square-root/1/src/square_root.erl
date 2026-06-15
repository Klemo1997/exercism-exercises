-module(square_root).

-export([square_root/1]).

square_root(Radicand) -> square_root(Radicand, 1).

square_root(Radicand, Candidate) when Candidate * Candidate == Radicand -> Candidate;
square_root(Radicand, Candidate) when Candidate * Candidate < Radicand -> square_root(Radicand, Candidate + 1).