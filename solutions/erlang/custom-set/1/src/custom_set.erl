-module(custom_set).

-export([add/2, contains/2, difference/2, disjoint/2, empty/1, equal/2, from_list/1, intersection/2, subset/2,
	 union/2]).

add(Elem, Set) -> maps:put(Elem, elem, Set).

contains(Elem, Set) -> maps:is_key(Elem, Set).

difference(Set1, Set2) -> maps:without(maps:keys(Set2), Set1).

disjoint(Set1, Set2) -> equal(Set1, difference(Set1, Set2)).

empty(Set) -> Set == #{}.

equal(Set, Set) -> true;
equal(_, _) -> false.

from_list(List) -> lists:foldl(fun (Elem, Set) -> add(Elem, Set) end, #{}, List).

intersection(Set1, Set2) -> maps:with(maps:keys(Set2), Set1).

subset(Set1, Set2) -> intersection(Set2, Set1) == Set1.

union(Set1, Set2) -> maps:merge(Set1, Set2).

