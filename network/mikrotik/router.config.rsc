# dec/27/2023 11:50:57 by RouterOS 6.49.7
# software id = ZINE-7FTI
#
# model = RouterBOARD 952Ui-5ac2nD
# serial number = 6B33060BDD67
/interface bridge
add admin-mac=6C:3B:6B:86:93:0D auto-mac=no comment=defconf name=bridge
add name=wan
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n channel-width=20/40mhz-XX \
    country="united states" disabled=no distance=indoors frequency=auto \
    installation=indoor mode=ap-bridge ssid=svHarmony24 wireless-protocol=\
    802.11
/interface list
add comment=defconf name=WAN
add comment=defconf name=LAN
/interface wireless security-profiles
set [ find default=yes ] authentication-types=wpa2-psk,wpa2-eap mode=\
    dynamic-keys supplicant-identity=MikroTik wpa2-pre-shared-key=\
    "secret"
/interface wireless
set [ find default-name=wlan2 ] band=5ghz-a/n/ac channel-width=\
    20/40/80mhz-eeCe country="united states" disabled=no distance=indoors \
    frequency=auto installation=indoor mode=ap-bridge security-profile=\
    svHarmony ssid=svHarmony wireless-protocol=802.11
/ip pool
add name=dhcp ranges=192.168.3.10-192.168.3.254
/ip dhcp-server
add address-pool=dhcp disabled=no interface=bridge name=defconf
/interface bridge port
add bridge=bridge comment=defconf interface=ether2
add bridge=bridge comment=defconf interface=ether3
add bridge=bridge comment=defconf interface=ether4
add bridge=wan comment=defconf interface=ether5
add bridge=bridge comment=defconf interface=wlan1
add bridge=bridge broadcast-flood=no comment=defconf interface=wlan2
add bridge=wan interface=ether1
/ip neighbor discovery-settings
set discover-interface-list=LAN
/interface list member
add comment=defconf interface=bridge list=LAN
add comment=defconf interface=ether1 list=WAN
add interface=ether2 list=LAN
add interface=ether3 list=LAN
add interface=ether4 list=LAN
add interface=ether5 list=WAN
add interface=wlan2 list=LAN
add interface=wlan1 list=LAN
/ip address
add address=192.168.3.1/24 comment=defconf interface=bridge network=\
    192.168.3.0
/ip dhcp-client
# DHCP client can not run on slave interface!
add comment=defconf disabled=no interface=ether5
add interface=wlan2
/ip dhcp-server lease
add address=192.168.3.5 client-id=\
    ff:6:42:2d:e4:0:1:0:1:2b:7:f8:3:0:1e:6:42:2d:e4 mac-address=\
    00:1E:06:42:2D:E4 server=defconf
/ip dhcp-server network
add address=192.168.3.0/24 comment=defconf dns-server=192.168.88.1 gateway=\
    192.168.3.1 netmask=24
/ip dns
set allow-remote-requests=yes
/ip dns static
add address=192.168.89.254 comment=defconf name=router.lan
/ip firewall filter
add action=accept chain=input comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=drop chain=input comment="defconf: drop invalid" connection-state=\
    invalid
add action=accept chain=input comment="defconf: accept ICMP" protocol=icmp
add action=accept chain=input comment=\
    "defconf: accept to local loopback (for CAPsMAN)" dst-address=127.0.0.1
add action=drop chain=input comment="defconf: drop all not coming from LAN" \
    in-interface-list=!LAN
add action=accept chain=forward comment="defconf: accept in ipsec policy" \
    ipsec-policy=in,ipsec
add action=accept chain=forward comment="defconf: accept out ipsec policy" \
    ipsec-policy=out,ipsec
add action=fasttrack-connection chain=forward comment="defconf: fasttrack" \
    connection-state=established,related
add action=accept chain=forward comment=\
    "defconf: accept established,related, untracked" connection-state=\
    established,related,untracked
add action=drop chain=forward comment="defconf: drop invalid" \
    connection-state=invalid
add action=drop chain=forward comment=\
    "defconf: drop all from WAN not DSTNATed" connection-nat-state=!dstnat \
    connection-state=new in-interface-list=WAN
/ip firewall nat
add action=masquerade chain=srcnat comment="defconf: masquerade" \
    ipsec-policy=out,none out-interface=wan
/ip service
set telnet disabled=yes
set ftp disabled=yes
set api disabled=yes
set winbox disabled=yes
set api-ssl disabled=yes
/system clock
set time-zone-name=America/New_York
/tool mac-server
set allowed-interface-list=LAN
/tool mac-server mac-winbox
set allowed-interface-list=LAN
