now=$(date +"%m_%d_%Y__%H:%M:%S")
nwndir=/home/nsv/games/00829/bin/linux-x86;
nwnlogsdir=/home/nsv/.local/share/'Neverwinter Nights'/logs
nwnserver=""

curl https://api.nwn.beamdog.net/v1/servers

# pushd "$nwndir"
# ./nwmain-linux +connect "$nwnserver" "$@"
# popd

# pushd "$nwnlogsdir"
# cp nwclientLog1.txt $now
# popd

