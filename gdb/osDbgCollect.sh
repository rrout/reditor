#!/bin/bash
echo "======> "
date

echo "======> cat /proc/devices"
cat /proc/devices
echo "======> "

echo "======> cat /proc/interrupts"
cat /proc/interrupts
echo "======> "

echo "======> cat /proc/iomem"
cat /proc/iomem
echo "======> "

echo "======> cat /proc/meminfo"
cat /proc/meminfo
echo "======> "

echo "======> cat /proc/buddyinfo"
cat /proc/buddyinfo
echo "======> "

echo "======> cat /proc/slabinfo"
cat /proc/slabinfo
echo "======> "

echo "======> cat /proc/uptime"
cat /proc/uptime
echo "======> "

echo "======> cat /proc/vmstat"
cat /proc/vmstat
echo "======> "

echo "======> cat /proc/vmallocinfo"
cat /proc/vmallocinfo
echo "======> "

echo "======> cat /proc/zoneinfo"
cat /proc/zoneinfo
echo "======> "

echo "======> cat /proc/cmdline"
cat /proc/cmdline
echo "======> "

echo "======> lsmod"
lsmod
echo "======> "

echo "======> lspci"
lspci
echo "======> "

echo "======> ps -m -eo pid,ppid,nlwp,tid,cls,rtprio,comm,state,psr,pcpu,time,rsz,vsz,%mem,wchan"
ps -m -eo pid,ppid,nlwp,tid,cls,rtprio,comm,state,psr,pcpu,time,rsz,vsz,%mem,wchan
echo "======> "

echo "======> mount"
mount
echo "======> "

echo "======> netstat -na"
netstat -nap
echo "======> "

echo "======> free"
free
echo "======> "

echo "======> tty"
tty
echo "======> "

echo "======> df"
df
echo "======> "

echo "======> ifconfig"
ifconfig -a
echo "======> "

echo "======> ip addr show"
ip addr show
echo "======> "

for (( i=1; i<=8; i++ ))
do
    echo "======> cat /proc/ping" $i
    cat /proc/ping$i
    echo "======> "
done

echo "======> ip netns list"
ip netns list | sort
echo "======> "

for ns in `ip netns list | sort`; do
    echo "======> ip netns exec " $ns " ifconfig -a"
    ip netns exec $ns ifconfig -a
    echo "======> "
done

echo "======> ls /dev"
ls -l /dev
echo "======> "

echo "======> route"
route
echo "======> "

echo "======> arp"
arp
echo "======> "

echo "======> w"
w
echo "======> "

echo "======> printenv"
printenv
echo "======> "

echo "======> ulimit -a"
ulimit -a
echo "======> "

echo "======> sysctl -a"
sysctl -a
echo "======> "

echo "======> systemctl status"
systemctl --no-pager status
echo "======> "

echo "======> ======> ======> ======> ======> ======> ## OSPF ======> ======> ======> ======> ======> ======> ##"
echo "======>  ls -la /etc/quagga"
ls -la /etc/quagga
echo "======> "

echo "======>  cat /etc/quagga/ospfd.conf"
cat /etc/quagga/ospfd.conf
echo "======> "
echo "======>  cat /etc/quagga/zebra.conf"
cat /etc/quagga/zebra.conf
echo "======> "

echo "======>  vtysh -c \"show version\""
vtysh -c "show version"
echo "======> "
echo "======>  vtysh -c \"show daemons\""
vtysh -c "show daemons"
echo "======> "
echo "======>  vtysh -c \"show memory\""
vtysh -c "show memory"
echo "======> "
echo "======>  vtysh -c \"show startup-config\""
vtysh -c "show startup-config"
echo "======> "
echo "======>  vtysh -c \"show running-config\""
vtysh -c "show running-config"
echo "======> "
echo "======>  vtysh -c \"show interface\""
vtysh -c "show interface"
echo "======> "
echo "======>  vtysh -c \"show route-map\""
vtysh -c "show route-map"
echo "======> "
echo "======>  vtysh -c \"show ip access-list\""
vtysh -c "show ip access-list"
echo "======> "
echo "======>  vtysh -c \"show ip forwarding\""
vtysh -c "show ip forwarding"
echo "======> "
echo "======>  vtysh -c \"show ip route\""
vtysh -c "show ip route"
echo "======> "
echo "======>  vtysh -c \"show ip ospf route\""
vtysh -c "show ip ospf route"
echo "======> "
echo "======>  vtysh -c \"show ip ospf interface\""
vtysh -c "show ip ospf interface"
echo "======> "
echo "======>  vtysh -c \"show ip ospf neighbor\""
vtysh -c "show ip ospf neighbor"
echo "======> "
echo "======>  vtysh -c \"show ip ospf database\""
vtysh -c "show ip ospf database"
echo "======> "

# systemd
echo "======>  Systemd start graph(file:systemd_start_graph.svg)"
/usr/bin/systemd-analyze plot > /var/log/systemd_start_graph.svg
echo "======>  Systemd startup time."
/usr/bin/systemd-analyze --no-pager
echo "======>  systemd-analyze blame."
/usr/bin/systemd-analyze blame --no-pager
echo "======>  systemd-analyze critical-chain."
/usr/bin/systemd-analyze critical-chain --no-pager

