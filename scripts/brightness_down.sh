#!/bin/bash

current_brightness=$(ddcutil getvcp 10 -t | awk '{print $4}')
if (( current_brightness <= 5  ))
then
	ddcutil -d 1 setvcp 10 5
	echo "Already under 5"
	exit
fi
ddcutil -d 1 setvcp 10 $((current_brightness - 5))
