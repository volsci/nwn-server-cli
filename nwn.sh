#!/bin/bash

now=$(date +"%m_%d_%Y__%H:%M:%S")
nwndir=$(find . -name "nwmain-linux" -exec dirname {} \;);
nwnlogsdir=$(find . -name "nwclientLog1.txt" -exec dirname {} \;);
address=""

echo $nwndir
echo $nwnlogsdir

# Check that jq is installed
if ! [ -x "$(command -v jq)" ]; then
  echo 'Error: git is not installed.' >&2
  exit 1
fi

# Check for the existence of an argument, and if one exists, direct connect
# and bypass the serverlist
if [ $# -eq 0 ]
    then
        servernames=$(curl -sS https://api.nwn.beamdog.net/v1/servers )
        echo $servernames | jq -r -C '. | sort_by(.current_players) | .[] | "\(.session_name) | Players: \(.current_players) / \(.max_players)"' | nl --starting-line-number=0
        echo "Pick a Server:"
        read serverpick
        address=`echo $servernames | jq -r --argjson serverpick $serverpick '. | .[$serverpick] | "\(.host):\(.port)"'`
    else
        address=$1
fi

pushd "$nwndir"
    ./nwmain-linux +connect "$address" "$@"
popd

pushd "$nwnlogsdir"
    cp nwclientLog1.txt $now
popd

