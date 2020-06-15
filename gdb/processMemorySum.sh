#!/bin/sh

cd /proc
printf "%5s %-20s     %-10s %-10s\n" "pid" "name" "Rss" "Pss"
for pid in `ls -d [0-9]*` ; do
  if [ -f /proc/$pid/comm ]; then
    printf "%5d " $pid
    cat /proc/$pid/comm | awk '{printf "%-20s     ",$1}'
    cat /proc/$pid/smaps | awk '/^Rss/{sum += $2}END{printf "%10d ",sum}'
    cat /proc/$pid/smaps | awk '/^Pss/{sum += $2}END{printf "%10d\n",sum}'
  fi
done

