#!/bin/bash

for i in $(seq 1 $1)
do
	./newmem.bash $2&
	sleep 1
done
