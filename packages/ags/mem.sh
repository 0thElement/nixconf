#!/bin/sh

printf "%.0f\n" $(free -m | grep Mem | awk '{print (1-$7/$2)*100}')
