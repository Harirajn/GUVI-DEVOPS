#!/bin/bash

export u=`whoami`
d=$(pwd)
r=$(last reboot)
sh /home/hari/test.sh
echo "i am $u" 
echo  "Present working directory is $d"
echo "My system last rebooted on $r"