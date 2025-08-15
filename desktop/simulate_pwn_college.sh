#!/bin/bash

# Flag is already in base image
#sudo echo "pwn.college{simulated_flag}" > /flag
#sudo chmod 0600 /flag

sudo chmod 0755 /challenge/*
sudo chmod o+s /challenge/*

if [ -e /challenge/.init ]; then
	sudo /challenge/.init
fi

/home/hacker/internal_launch_desktop.sh &

