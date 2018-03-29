now=$(date +"%m_%d_%Y__%H:%M:%S")
nwndir=/<YOUR PATH>/linux-x86;
nwnlogsdir=/<YOUR PATH>/'Neverwinter Nights'/logs
nwnserver=""

serverlist=$(curl -sS https://api.nwn.beamdog.net/v1/servers)
echo $serverlist | jq -r '.[] .session_name'




# pushd "$nwndir"
# ./nwmain-linux +connect "$nwnserver" "$@"
# popd

# pushd "$nwnlogsdir"
# cp nwclientLog1.txt $now
# popd

