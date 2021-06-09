# Mikrotik point to point wireless configuration

This guide explains how to configure you Mikrotik devices to be used as wireless point-to-point link.
These configurations have been tested two SXTsq 5 ac devices.

## Overview of point-to-point

In point-to-point connection, one of the devices acts as a server and the other one as a client.
After the connection has been established, the server and client roles don't matter.
Both devices can send and receive data.
The bridge is the server device and the station bridge is the client.
The bridge creates an acceppoint where the station bridge will connect to.
The configurations are decided by the bridge.
After the connection has been established between the bridge and station bridge,
both devices will transparently forward traffic wirelessly over the link.

## Installing the configurations

### Upload the configuration
Use Webfig or WinBox
Upload the file to the device:
Files - Upload... or drag it.
Note! the file has to be in the flash folder.

### Take the configuration into use
System - Reset Configuration - Run After Reset (the file you uploaded)

## The bridge config explained
This is to identify your device.
```
/system identity set name=The_Bridge
```
Create security for the wireless link.
We're using WPA2-PSK (preshared key).
```
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa2-psk disable-pmkid=yes eap-methods="" mode=dynamic-keys name=WPA2_PSK supplicant-identity=MikroTik \
    wpa2-pre-shared-key=YourPasswordHere
```
Configure the wireless link.
Since both devices support ac, we're going to fix the server to ac.
For this example, country is set to no country.
Be sure to set it to your actual country.
Installation is any. Other options are indoor and outdoor.
Scan list has been set to scan 5180, 5200, 5220 and 5240 MHz.
These may not be available in your country.
Change accordingly.
The name of WLAN is Linna (castle in Finnish).
Wireless protocol is 802.11, which is the same as what is used in home wireless networks.
It works well up to about 1 kilometer links.
For longer links, use for example nv2.
We use WPA2-PSK security configured in previous step.
WPS mode has been disabled.
```
/interface wireless
set [ find default-name=wlan1 ] band=5ghz-onlyac channel-width=20/40/80mhz-XXXX country=no_country_set disabled=no frequency=auto installation=\
    any mode=bridge scan-list=5180,5200,5220,5240 security-profile=WPA2_PSK ssid=Linna wireless-protocol=802.11 wps-mode=disabled
```
Bridge the wireless and wired interfaces
```
/interface bridge add name=bridge1
/interface bridge port
add bridge=bridge1 interface=ether1
add bridge=bridge1 interface=wlan1
```
Make discoverable by maintenenance tools
```
/ip neighbor discovery-settings set discover-interface-list=all
```
Add an ip address so you can connect with an ip address.
If this is not added, you can still connect using WinBox with the MAC address.
Change this ip address according to your home network.
Other option is configuring a DHCP client for the **bridge**.
```
/ip address add address=192.168.1.251/24 comment="Service IP" interface=bridge1 network=192.168.1.0
```
