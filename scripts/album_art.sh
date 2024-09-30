#!/bin/bash

album_art=$(playerctl metadata mpris:artUrl)
status=$(playerctl status)

if [[ -z $album_art ]] 
then
   rm /tmp/cover_round.png
   rm /tmp/album_art.txt
   echo ""
   exit
fi

if [[ $(cat /tmp/album_art.txt) == $album_art ]]
then
	exit
fi

echo $album_art > /tmp/album_art.txt
curl -s "${album_art}" --output "/tmp/cover.jpeg"
mogrify -resize 128x128^ -gravity center -extent 128x128 /tmp/cover.jpeg
magick /tmp/cover.jpeg -alpha set \( +clone -alpha extract -draw "fill black polygon 0,0 0,24 24,0 fill white circle 24,24 24, 0" \( +clone -flip \) -compose Multiply -composite \( +clone -flop \) -compose Multiply -composite \) -alpha off -compose CopyOpacity -composite /tmp/cover_round.png
rm /tmp/cover.jpeg

echo "/tmp/cover_round.png"
