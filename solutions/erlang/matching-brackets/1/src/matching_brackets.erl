-module(matching_brackets).

-export([is_paired/1]).


is_paired(String) -> is_paired([], String).

is_paired(Stack, [$[ | String]) -> is_paired([$[ | Stack], String);
is_paired([$[ | Stack], [$] | String]) -> is_paired(Stack, String);

is_paired(Stack, [${ | String]) -> is_paired([${ | Stack], String);
is_paired([${ | Stack], [$} | String]) -> is_paired(Stack, String);

is_paired(Stack, [$( | String]) -> is_paired([$( | Stack], String);
is_paired([$( | Stack], [$) | String]) -> is_paired(Stack, String);

is_paired(Stack, [NonBracket | String]) when NonBracket /= $] andalso NonBracket /= $} andalso NonBracket /= $) -> 
    is_paired(Stack, String);
is_paired([], []) -> true;
% Unopened closing bracket, or non-empty stack at the end fallbacks here.
is_paired(_, _) -> false.

