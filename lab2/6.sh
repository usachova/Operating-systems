#!/bin/bash

grep "VmRSS" /proc/*/status | sed "s/[^0-9]\+/ /g"| sed "s/^ //" | sort -nrk2 | head -1 | awk '{print "PID: "$1" RES: "$2}'
