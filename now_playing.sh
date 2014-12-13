#!/bin/bash
i=0
j=0
while true; do if [ $i == 0 ]; then max=`grep -v "^#" /home/andrew/radio_motd.txt | wc -l`; echo -e "\e]0;  `grep -v "^#" /home/andrew/radio_motd.txt | tail -n+$(expr $j + 1) | head -n 1`"; let j=(j+1)%max; fi; ncmpcpp --now-playing | cut -c1-78 | tr -d '\n' | head -c 78 | cat <(echo) -; sleep 1; let i=(i+1)%10; done
