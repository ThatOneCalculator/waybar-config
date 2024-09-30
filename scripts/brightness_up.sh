#!/bin/bash

current_brightness=$(ddcutil getvcp 10 -t | awk '{print $4}')
if (( current_brightness >= 95  ))
then
	ddcutil -d 1 setvcp 10 100
	echo "Already 100"
	exit
fi
ddcutil -d 1 setvcp 10 $((current_brightness + 5))
