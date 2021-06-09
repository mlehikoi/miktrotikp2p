# station bridge
/system identity set name=The_Station_Bridge
/interface bridge add name=bridge1
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa2-psk disable-pmkid=yes eap-methods="" mode=dynamic-keys name=WPA2_PSK supplicant-identity=MikroTik \
    wpa2-pre-shared-key=YourPasswordHere
/interface wireless
set [ find default-name=wlan1 ] band=5ghz-onlyac channel-width=20/40/80mhz-XXXX country=no_country_set disabled=no frequency=auto installation=\
    any mode=station-bridge security-profile=WPA2_PSK skip-dfs-channels=all ssid=Linna wireless-protocol=802.11
/interface bridge port
add bridge=bridge1 interface=ether1
add bridge=bridge1 interface=wlan1
/ip neighbor discovery-settings set discover-interface-list=all
/ip address
add address=192.168.1.252/24 comment="Service IP" interface=bridge1 network=192.168.1.0
