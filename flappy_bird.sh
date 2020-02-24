#!/bin/bash
#service bird status | grep -q dead && echo $?
if $(service bird status | grep -q stop)
then
	echo $(date) "Starting Bird"
        sudo service bird start
else
        echo $(date) "Stopping Bird"
	sudo service bird stop
fi
