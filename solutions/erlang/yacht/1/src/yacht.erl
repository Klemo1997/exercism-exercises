-module(yacht).

-export([score/2]).

score([_, _, _, _, _] = Dice, Category) -> get_score(lists:sort(Dice), Category).

get_score(Dice, ones) -> occurrences(Dice, 1);
get_score(Dice, twos) -> occurrences(Dice, 2) * 2;
get_score(Dice, threes) -> occurrences(Dice, 3) * 3;
get_score(Dice, fours) -> occurrences(Dice, 4) * 4;
get_score(Dice, fives) -> occurrences(Dice, 5) * 5;
get_score(Dice, sixes) -> occurrences(Dice, 6) * 6;

get_score([A, A, A, A, A], full_house) -> 0;
get_score([A, A, A, B, B] = Dice, full_house) -> lists:sum(Dice);
get_score([A, A, B, B, B] = Dice, full_house) -> lists:sum(Dice);
get_score(_, full_house) -> 0;

get_score([A, A, A, A, _], four_of_a_kind) -> 4 * A;
get_score([_, A, A, A, A], four_of_a_kind) -> 4 * A;
get_score(_, four_of_a_kind) -> 0;

get_score([1, 2, 3, 4, 5], little_straight) -> 30;
get_score(_, little_straight) -> 0;

get_score([2, 3, 4, 5, 6], big_straight) -> 30;
get_score(_, big_straight) -> 0;

get_score(Dice, choice) -> lists:sum(Dice);

get_score([A, A, A, A, A], yacht) -> 50;
get_score(_, yacht) -> 0;

get_score(Dice, _) -> 0.

occurrences(List, Val) -> length([Item || Item <- List, Item == Val]).