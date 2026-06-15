-module(meetup).

-export([meetup/4]).

meetup(Year, Month, DayOfWeek, Week) -> 
    LastDay = last_day_of_month({Year, Month, 1}),
    DateRange = lists:map(fun (Day) -> {Year, Month, Day} end, lists:seq(1, LastDay)),
    find_date(DateRange, order(DayOfWeek), Week).

find_date(Days, WeekDay, first) -> find(Days, fun(Date) -> calendar:day_of_the_week(Date) == WeekDay end);
find_date(Days, WeekDay, second) -> 
    {Year, Month, Day} = find_date(Days, WeekDay, first),
    {Year, Month, Day + 7};
find_date(Days, WeekDay, third) -> 
    {Year, Month, Day} = find_date(Days, WeekDay, first),
    {Year, Month, Day + 14};
find_date(Days, WeekDay, fourth) -> 
    {Year, Month, Day} = find_date(Days, WeekDay, first),
    {Year, Month, Day + 21};
find_date(Days, WeekDay, last) -> find_date(lists:reverse(Days), WeekDay, first);
find_date(Days, WeekDay, teenth) -> find(Days, 
                                        fun({_, _, Day} = Date) -> 
                                            calendar:day_of_the_week(Date) == WeekDay andalso lists:member(Day, lists:seq(13, 19))
                                        end).

order(monday) -> 1;
order(tuesday) -> 2;
order(wednesday) -> 3;
order(thursday) -> 4;
order(friday) -> 5;
order(saturday) -> 6;
order(sunday) -> 7.

find([Item | List], Predicate) ->
    Result = Predicate(Item),
    if
        Result -> Item;
        true -> find(List, Predicate)
    end;
find([], _) -> nil.

last_day_of_month({Year, Month, _}) -> find([31, 30, 29, 28], fun(MaybeLastDay) -> calendar:valid_date({Year, Month, MaybeLastDay}) end).