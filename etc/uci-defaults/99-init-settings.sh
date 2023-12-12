#!/bin/sh

# lang
uci set luci.main.lang=en
uci commit luci

# timezone
uci set system.@system[0].timezone=WIB-7
uci set system.@system[0].zonename=Asia/Jakarta

# zram-swap
uci set system.@system[0].zram_priority=100

# ntp server
uci -q delete system.ntp.server
uci add_list system.ntp.server="time.indonesia.in"
uci add_list system.ntp.server="ntp.indosat.com"
uci add_list system.ntp.server="time3.jaring.id"
uci add_list system.ntp.server="time.cloudflare.com"  # Cloudflare's NTP server
uci commit system && service sysntpd reload

# xmm interface
uci set network.l860GL=interface
uci set network.l860GL.proto='xmm'
uci set network.l860GL.device='/dev/ttyACM0'
uci set network.l860GL.apn='internet'
uci set network.l860GL.auth='auto'
uci set network.l860GL.pdp='ipv4v6'
uci add_list network.l860GL.dns='8.8.8.8'
uci add_list network.l860GL.dns='8.8.4.4'
uci commit network
/etc/init.d/network restart

#install apk
cd /aplikasi
opkg install *.ipk
rm -rf /aplikasi

# Fixing Bug
sed -i "/config uhttpd 'main'/a list interpreter '.php=/usr/bin/php-cgi'" /etc/config/uhttpd
sed -i "/config uhttpd 'main'/a option ubus_prefix '/ubus'" /etc/config/uhttpd
sleep 1
reboot

exit 0
