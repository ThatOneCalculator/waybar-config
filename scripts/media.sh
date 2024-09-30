
#!/bin/bash

playerstatus=$(playerctl status 2>&1)

case "$playerstatus" in
	"No players found") echo "";;
	"Stopped") echo "Paused";;
	*)
		status=$(playerctl --player=playerctld metadata --format "{{ title }}")
    echo "${status}"
esac
