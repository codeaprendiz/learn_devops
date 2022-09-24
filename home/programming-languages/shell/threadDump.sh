#!/bin/bash

if [ $# -eq 0 ]; then
    echo >&2 "Usage: jstackSeries  [ <count> [ <delay> ] ]"
    echo >&2 "    Defaults: count = 10, delay = 1 (seconds)"
    exit 1
fi

pid=$1          # required
count=${2:-10}  # defaults to 10 times
delay=${3:-1} # defaults to 1 second

while [ $count -gt 0 ]
do
    jstack $pid >jstack.PID.$pid.TIMESTAMP.$(date +%H%M%S.%N)
    sleep $delay
    let count--
    echo -n "."
done
