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

#fixphp

wget -O /bin/fixphp "https://raw.githubusercontent.com/helmiau/openwrt-config/main/fix-xderm-libernet-gui" && chmod +x /bin/fixphp

exit 0