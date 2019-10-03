#!/usr/bin/env bash

stamps=$(curl -s -X GET "http://transport.opendata.ch/v1/connections?to=Fribourg&from=Mont-carmel" | \
    jq -r '.connections[] | "\(.from.departureTimestamp),\(.to.arrivalTimestamp)"')

export IFS=$'\n'

for stamp in $stamps; {
    printf "From %(%H:%M)T to %(%H:%M)T\n" \
        "${stamp%%,*}" \
        "${stamp##*,}"
}
