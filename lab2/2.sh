#!/bin/bash

ps ax | grep "/sbin/" | awk '{print $1 }' > ans2
