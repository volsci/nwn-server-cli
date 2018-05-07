#!/bin/bash

now=$(date +"%m_%d_%Y__%H:%M:%S")
nwndir=/path/linux-x86;
nwnlogsdir=/path/.local/share/'Neverwinter Nights'/logs
nwnserver=""
servernames=$(curl -sS https://api.nwn.beamdog.net/v1/servers )

echo $servernames | jq -r -C '. | sort_by(.current_players) | .[] | "\(.session_name) | Players: \(.current_players) / \(.max_players)"' | nl --starting-line-number=0

echo "Pick a Server:"
read serverpick
address=`echo $servernames | jq -r --argjson serverpick $serverpick '. | .[$serverpick] | "\(.host):\(.port)"'`

pushd "$nwndir"
    ./nwmain-linux +connect "$address" "$@"
popd

pushd "$nwnlogsdir"
    cp nwclientLog1.txt $now
popd

