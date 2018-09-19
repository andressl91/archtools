#!/bin/sh
#
# z3bra - (c) wtfpl 2014
# Fetch infos on your computer, and print them to stdout every second.

Clock () {
        DATETIME=$(date "+%a %b %d, %T")
        echo -n "$DATETIME"
} 

Battery () {
        BATPERC=$(acpi --battery | cut -d, -f2)
        echo "$BATPERC"

}
while :; do

    buf=""
    buf="${buf} %{c}%{F#FFFF00}%{B#0000FF} $(Clock) %{F-}%{B-}"
    buf="${buf} Battery $(Battery)"
    echo $buf
    sleep 0.5
done



