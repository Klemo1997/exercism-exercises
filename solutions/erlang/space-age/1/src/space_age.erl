-module(space_age).

-export([age/2]).

-define(EARTH_YEAR_SECONDS, 31557600).

age(mercury, Seconds) -> Seconds / ?EARTH_YEAR_SECONDS / 0.2408467;
age(venus, Seconds) -> Seconds / ?EARTH_YEAR_SECONDS / 0.61519726;
age(earth, Seconds) -> Seconds / ?EARTH_YEAR_SECONDS;
age(mars, Seconds) -> Seconds / ?EARTH_YEAR_SECONDS / 1.8808158;
age(jupiter, Seconds) -> Seconds / ?EARTH_YEAR_SECONDS / 11.862615;
age(saturn, Seconds) -> Seconds / ?EARTH_YEAR_SECONDS / 29.447498;
age(uranus, Seconds) -> Seconds / ?EARTH_YEAR_SECONDS / 84.016846;
age(neptune, Seconds) -> Seconds / ?EARTH_YEAR_SECONDS / 164.79132.
