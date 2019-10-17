#!/usr/bin/env bash

SBB_HTTP_URL="http://fahrplan.sbb.ch/bin/query.exe/dn?jumpToDetails=yes"
SBB_API_BASE='http://transport.opendata.ch/v1/connections'

function usage {
    echo "Usage ./sbb.sh OPTIONS FROM TO"
    echo "  OPTIONS:"
    echo "      -t  Time to search for connections"
    echo "      -d  Date to search for connections"
    echo "      -v  Spevifies a via Station"
    echo "      -a  Uses the Date and Time for Arrival"
    echo "      -i  Use it and be happy"
    exit
}

function append_if_not_empty {
    if [ -z "$2" ] || [ "$2" = "null" ] ; then
        echo $1
    else
        echo "$1$3"
    fi
}

function request_connection {
    queryString="from=$1&to=$2"
    queryString=$(append_if_not_empty $queryString "$3" "&via=$3")
    queryString=$(append_if_not_empty $queryString "$4" "&date=$4")
    queryString=$(append_if_not_empty $queryString "$5" "&time=$5")
    queryString=$(append_if_not_empty $queryString "$6" "&isArrivalTime=$6")
    
    resultJson=$(curl -s "$SBB_API_BASE?$queryString")
    
    local i_connection=0
    echo $resultJson | jq -r '.connections[].duration' | while read connection; do
	print_connection "$resultJson" ".connections[$i_connection]"
	(( i_connection++ ))
    done
}

function print_connection {
    print_connection_header "$1" "$2"

    local i_section=0
    echo $1 | jq -r "$2.sections[].departure.station.name" | while read section; do
	print_section "$1" "$2.sections[$i_section]" $i_section
	(( i_section++ ))
    done
}

function print_connection_header {
    echo ""
    
    station_from=$(echo $1 | jq -r "$2.from.station.name")
    station_to=$(echo $1 | jq -r "$2.to.station.name")

    echo "$station_from - $station_to"
    
    if [[ "$os" = Linux ]]; then
        departure_time=$(date -d @$(echo $1 | jq -r "$2.from.departureTimestamp") +"%H:%M")
        arrival_time=$(date -d @$(echo $1 | jq -r "$2.to.arrivalTimestamp") +"%H:%M")
	duration=$(echo $(echo $1 | jq -r "$2.duration") | sed -r 's/^[0-9]+d//gi')
    elif [[ "$os" = "macOS" ]]; then
        departure_time=$(date -j -f "%s" $(echo $1 | jq -r "$2.from.departureTimestamp") +"%H:%M")
        arrival_time=$(date -j -f "%s" $(echo $1 | jq -r "$2.to.arrivalTimestamp") +"%H:%M")
	duration=$(echo $(echo $1 | jq -r "$2.duration") | sed -E 's/^[0-9]+d//g')
    else
	echo "Unkown OS"
	exit 1
    fi
    transfers=$(echo $1 | jq -r "$2.transfers")

    echo "Abfahrt: $departure_time"
    echo "Ankunft: $arrival_time"
    echo "Dauer: $duration, Umsteigen: $transfers"
}

function print_section {
    station=$(printf "%-15s" "$(echo $1 | jq -r "$2.departure.station.name")")
    if [[ "$os" = Linux ]]; then
	stime=$(date -d @$(echo $1 | jq -r "$2.departure.departureTimestamp") +"%H:%M")
    elif [[ "$os" = "macOS" ]]; then
	stime=$(date -j -f "%s" $(echo $1 | jq -r "$2.departure.departureTimestamp") +"%H:%M")
    else
	echo "Unkown OS"
	exit 1
    fi
    platform=$(echo $1 | jq -r "$2.departure.platform")
    product=$(echo $1 | jq -r "$2.journey.name")
    walk_object=$(echo $1 | jq -r "$2.walk")

    if [ $i_section -ne 0 ] && [ "$walk_object" = "null" ] ; then
	prev_section=".connections[$i_connection].sections[$(($i_section - 1))]"
	prev_walk_object=$(echo $1 | jq -r "$prev_section.walk")
	if [ "$prev_walk_object" = "null" ] ; then
	   echo "|  - [Umsteigen]"
	fi
    fi

    if [ "$walk_object" != "null" ] ; then
	echo "|  - [Fussweg]"
    else
	departure_string="+- $station ab $stime"
	departure_string=$(append_if_not_empty "$departure_string" "$platform" ": Gleis $platform")
	departure_string=$(append_if_not_empty "$departure_string" "$product" " [$product]")
	echo "$departure_string"

        station=$(printf "%-15s" "$(echo $1 | jq -r "$2.arrival.station.name")")
        if [[ "$os" = Linux ]]; then
	    stime=$(date -d @$(echo $1 | jq -r "$2.arrival.arrivalTimestamp") +"%H:%M")
        elif [[ "$os" = "macOS" ]]; then
	    stime=$(date -j -f "%s" $(echo $1 | jq -r "$2.arrival.arrivalTimestamp") +"%H:%M")
        else
	    echo "Unkown OS"
	    exit 1
	fi
	
	platform=$(echo $1 | jq -r "$2.arrival.platform")

	arrival_string="+- $station an $stime"
	arrival_string=$(append_if_not_empty "$arrival_string" "$platform" ": Gleis $platform")
        echo "$arrival_string"
    fi
}

function print_ascii_art {
    echo " ____ ____ ____ _________ ____ ____ ____ ____ ____ "
    echo "||C |||L |||I |||       |||R |||U |||L |||E |||Z ||"
    echo "||__|||__|||__|||_______|||__|||__|||__|||__|||__||"
    echo '|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|'
    echo ""
    echo "Created by absturztaube <me@absturztau.be>"
    echo "Contributors:"
    echo " - nohillside"
    echo ""
    echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░░░░░░▒▓██████▓▓▓███▓▒░░░░░░░░░░░░░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░░░░▒████████████████████▓░░░░░░░░░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░░▒████████████████████████▓░░░░░░░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░▓▓██████████████████████████▒░░░░░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░█████████████████████████████▒░░░░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░▓█████████████████████████████▓░░░░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░█████████████████████████████████▓░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░▒██████████████████▓█████████████████▓░░░░░░░░"
    echo "░░░░░░░░░░░░▒▓███▒███████████▓▒▒▒▓██████████████▓▒░░░░░░░░░"
    echo "░░░░░░░░░░░░░▓██▒▒▓█████▓██▓▒▒▒▒▒▓█████████████▒░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░▒▓▒▒▒▒▒▒█▓▒▒▒▒▒▒▒▒▒▒▒████████████▓░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓████████████▒░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓████████████▒░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░▓█████▒▒▒▒▒▓███████▒▒▒███████████▒░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░▓▓▒░░▒▓▒▒▒▒▓▒░░░░▒▓▒▒▒███████████▒░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░▒▒░░▒▓▓▒▒▒▓░░░░░▓░▒▒▒▒███████████▒░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░░▒▓▒▓▓▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒█▒▓███████▒░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░░▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒█████▓░░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░▒▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓█████▒░░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒████▒░░░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▓████▒░░░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░░▒▓▓▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓███▓░░░░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░░░░░░░▓▓▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒████░░░░░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░░░░░░░░░██████▓▒▒▒▒▒▒▒▒▒▒▓▒░░░░░░░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░░░░░░░░░▒████▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░"
    echo "░░░░░░░░░░░░░░░░░░░░░░░░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░"
    echo ""
    exit
}

os=Linux
[[ $(uname) = "Darwin" ]] && os=macOS

arrival=0
while getopts ":t:d:v:aiV" o; do
    case "${o}" in
        t)
            timestamp_raw=${OPTARG}
            timestamp=$(date -d $timestamp_raw +"%H:%M")
            ;;
        d)
            datestamp_raw=${OPTARG}
	    if [[ "$os" = Linux ]]; then
		datestamp=$(date -d "$(echo $datestamp_raw | sed -r 's/([0-9]+)\.([0-9]+)\.([0-9]+)/\3-\2-\1/')" +"%d.%m.%Y")
	    elif [[ "$os" = "macOS" ]]; then
		datestamp=$(date -j -f "%Y-%m-%d" "$(echo $datestamp_raw | sed -E 's/([0-9]+)\.([0-9]+)\.([0-9]+)/\3-\2-\1/')" +"%d.%m.%Y")
	    else
		echo "Unkown OS"
		exit 1
	    fi
            ;;
        v)
            via=${OPTARG}
            ;;
        a)
            arrival=1
            ;;
	i)
	    print_ascii_art
	    ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

from=$1
to=$2

if [ -z "${from}" ] || [ -z "${to}" ] ; then
    usage
    exit
fi

if [ -z "${datestamp}" ] ; then
    datestamp=$(date +"%d.%m.%Y")
fi

if [ -z "${timestamp}" ] ; then
    timestamp=$(date +"%H:%M")
fi

request_connection "$from" "$to" "$via" "$datestamp" "$timestamp" "$arrival"
