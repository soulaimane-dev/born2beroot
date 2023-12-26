#!/bin/bash

echo "#Architecture: $(uname -a)"
echo "#CPU physical: $(grep "physical id" /proc/cpuinfo | sort -u | wc -l)"
echo "#vCPU: $(grep "processor" /proc/cpuinfo | sort -u | wc -l)"
free_memory=$(free -m | grep 'Mem:' | awk '{print $4}')
total_memory=$(free -m | grep 'Mem:' | awk '{print $2}')
rate=$(free -m | grep 'Mem:' | awk '{printf "%.2f", ($3/$2) * 100}')
echo "#Memory Usage: $free_memory/$total_memory MB ($rate%)"
Disk_size=$(df -h --total | grep "total" | tr -d 'G' | awk '{printf $3 "/" $2 "Gb " "(%d%%)\n", ($3/$2) * 100}')
echo "#Disk Usage: $Disk_size"
CPU_Usage=$(mpstat -P ALL | grep "all" | awk '{print 100 - $13 "%"}')
echo "#CPU Usage: $CPU_Usage"
last_reboot=$(who -b | awk '{print $3 " " $4}')
echo "#Last boot: $last_reboot"
rate=$(free -m | grep 'Mem:' | awk '{printf "%.2f", ($3/$2) * 100}')
if lsblk | grep -q "lvm"; then
    check_lvm="yes"
else
    check_lvm="no"
fi
echo "#LVM use: $check_lvm"
connection=$(netstat | grep -c ESTABLISHED)
echo "#Connections TCP: $connection ESTABLISHED"
User_log=$(who | grep -c pts)
echo "#User log: $User_log"
IP_address=$(hostname -I)
MAC_address=$(ip addr | grep "ether" | awk '{print $2}')
echo "#Network IP: $IP_address ($MAC_address)"
sudo_counter=$(grep -c 'COMMAND' /var/log/sudo/sudo.log)
echo "#Sudo: $sudo_counter cmd"
