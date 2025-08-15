#!/bin/sh

if [ $# -lt 1 ]; then
	echo "Usage: run_desktop.sh CHALLENGE_DIRECTORY [SCRATCH_DIR]"
	echo "   Challenge directory gets mounted to /challenge"
	echo "   Scratch directoy is mounted to /home/hacker/scratch"
	exit 1
fi

# User should always specify challenge directory
CHAL_DIR=$(realpath $1)

if [ $# -eq 2 ]; then
	SCRATCH_DIR=$(realpath $2)
	echo "Starting with scratch dir"
	docker run --rm -it -p 5901:5901 -v $CHAL_DIR:/challenge:rw -v $SCRATCH_DIR:/home/hacker/scratch:rw,z --name pwn_desktop_sim mwales/pwncollege_desktop:test01 /bin/bash
	#docker run --rm -it -p 5901:5901 -v $CHAL_DIR:/challenge:rw -v $SCRATCH_DIR:/home/hacker/scratch:rw,z --name pwn_desktop_sim mwales/pwncollege_desktop:test01 /home/hacker/simulate_pwn_college.sh
else
	echo "Starting without scratch dir"
	echo "Mounting challenge directory to $CHAL_DIR"
	docker run --rm -it -p 5901:5901 -v $CHAL_DIR:/challenge:rw mwales/pwncollege_desktop:test01 /bin/bash
fi

exit 2

#docker run --rm -it -p 5901:5901 mwales/pwncollege_desktop:test01 /bin/bash
#docker run -p 5901:5901 -v /challenge:$CHAL_DIR:ro --name pwn_desktop_sim mwales/pwncollege_desktop:test01

#vncviewer 127.0.0.1:1

#docker stop pwn_desktop_sim
