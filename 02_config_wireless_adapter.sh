echo "-------------------------------------------------"
echo "Init. Config: CONFIG WIRELESS ADAPTER FOR HACKING"
echo "-------------------------------------------------"

interface='wlan0'

echo ''
echo "---------"
echo ''

echo "-> 01 - killing process of NetworkManager with airmon-ng" 
sudo airmon-ng check kill

echo ''
echo "---------"
echo ''

echo "-> 02 - Setting wireless in Managed mode"
sudo ifconfig $interface down
sudo iwconfig $interface mode Managed
sudo ifconfig $interface up

echo ''
echo "---------"
echo ''

echo "-> 03 - Setting fake MAC Address (00:11:22:33:44:55)"
sudo ifconfig $interface down
sudo ifconfig $interface hw ether 00:11:22:33:44:55
sudo ifconfig $interface up

echo ''
echo "---------"
echo ''

echo "-> 04 - Setting Monitor mode on wireless interface"
sudo ifconfig $interface down
sudo iwconfig $interface mode Monitor
sudo ifconfig $interface up

echo ''
echo "---------"
echo ''

echo "----------------"
echo "CONFIG COMPLETED"
echo "----------------"
