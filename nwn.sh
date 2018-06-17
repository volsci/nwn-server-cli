#!/bin/bash

now=$(date +"%m_%d_%Y__%H:%M:%S")
nwndir='';
nwnlogsdir='';
address=""

# Check that jq is currently installed
if ! [ -x "$(command -v jq)" ]; then
  echo 'Error: jq is not installed.' >&2
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

# Navigate to the directory of the game and direct connect to supplied server 
run_nwmain() {
    pushd "$nwndir"
        ./nwmain-linux +connect "$address" "$@"
    popd
}

# Handle incorrect file directory, prompt user for a new file path
error_run_nwmain() {
    echo 'Cannot find nwmain-linux in' $nwndir'. Please enter path:'
    read path
    nwndir=$path
}

# Duplicate the log file with timestamp 
rotate_log() {
    pushd "$nwnlogsdir"
        cp nwclientLog1.txt $now
    popd
}

# Handle incorrect file directory, prompt user for a new file path
error_rotate_log() {
    echo 'Cannot find nwclientLog1.txt in' $nwnlogsdir'. Please enter path:'
    read path
    nwnlogsdir=$path
}

# Prompt the user to enter the correct file path to nwmain until it is given
until run_nwmain; do
    error_run_nwmain
done

# Prompt the user to enter the correct file path to the logs until it is given
until rotate_log; do
    error_rotate_log
done
