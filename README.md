# NWN Server CLI
Using Beamdog's [serverlist](https://nwn.beamdog.net) API, this script allows for browsing and then directly connecting to a Neverwinter Nights Enhanced Edition server, as well as rotating and timestamping client logs, all from the comfort of the terminal.

### Log Rotating
Normally, the NWN client log is overriden every time the game is played. For those who play on NWN multiplayer servers, it is immensely useful to have an automatic log repository for making reports to the moderators or just to look back over. 

### Direct Connect
Direct connecting is purported to have a number of benefits for both the player and the server host. I can't remember what they are, so you'll just have to take my word for it, but being able to immediately join a server without having to trawl through clients and the in-game menu is something I personally want. 

## Dependencies
Requires `jq`.

## Todo
* Fix discrepancy between 0 and 1 starting arrays
* Error handling
* Script find the directories automatically
* Ability to pass a host:port argument and bypass the serverlist
* Colorize & format logs

