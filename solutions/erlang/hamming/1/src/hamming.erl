-module(hamming).

-export([distance/2]).


distance(Strand1, Strand2) -> distance(Strand1, Strand2, 0).

distance([Letter | Strand1], [Letter | Strand2], Distance) -> distance(Strand1, Strand2, Distance);
distance([_ | Strand1], [_ | Strand2], Distance) -> distance(Strand1, Strand2, Distance + 1);
distance([], [], Distance) -> Distance;
distance(_, _, _) -> {error, badarg}.