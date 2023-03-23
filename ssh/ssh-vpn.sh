#!/bin/bash
#
# ==================================================

# etc
apt dist-upgrade -y
apt install netfilter-persistent -y
apt-get remove --purge ufw firewalld -y
apt install -y screen curl jq bzip2 gzip vnstat coreutils rsyslog iftop zip unzip git apt-transport-https build-essential -y

# initializing var
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- ipinfo.io/ip);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

#detail nama perusahaan
country=ID
state=Indonesia
locality=Jakarta
organization=none
organizationalunit=none
commonname=none
email=none

# simple password minimal
curl -sS https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/password | openssl aes-256-cbc -d -a -pass pass:scvps07gg -pbkdf2 > /etc/pam.d/common-password
chmod +x /etc/pam.d/common-password

# go to root
cd

# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

# Ubah izin akses
chmod +x /etc/rc.local

# enable rc local
systemctl enable rc-local
systemctl start rc-local.service

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

#update
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y

#install jq
apt -y install jq

#install shc
apt -y install shc

# install wget and curl
apt -y install wget curl

#figlet
apt-get install figlet -y
apt-get install ruby -y
gem install lolcat

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

install_ssl(){
    if [ -f "/usr/bin/apt-get" ];then
            isDebian=`cat /etc/issue|grep Debian`
            if [ "$isDebian" != "" ];then
                    apt-get install -y nginx certbot
                    apt install -y nginx certbot
                    sleep 3s
            else
                    apt-get install -y nginx certbot
                    apt install -y nginx certbot
                    sleep 3s
            fi
    else
        yum install -y nginx certbot
        sleep 3s
    fi

    systemctl stop nginx.service

    if [ -f "/usr/bin/apt-get" ];then
            isDebian=`cat /etc/issue|grep Debian`
            if [ "$isDebian" != "" ];then
                    echo "A" | certbot certonly --renew-by-default --register-unsafely-without-email --standalone -d $domain
                    sleep 3s
            else
                    echo "A" | certbot certonly --renew-by-default --register-unsafely-without-email --standalone -d $domain
                    sleep 3s
            fi
    else
        echo "Y" | certbot certonly --renew-by-default --register-unsafely-without-email --standalone -d $domain
        sleep 3s
    fi
}

# install webserver
apt -y install nginx php php-fpm php-cli php-mysql libxml-parser-perl
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
curl https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/nginx.conf > /etc/nginx/nginx.conf
curl https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/vps.conf > /etc/nginx/conf.d/vps.conf
sed -i 's/listen = \/var\/run\/php-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php/fpm/pool.d/www.conf
useradd -m vps;
mkdir -p /home/vps/public_html
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html
cd /home/vps/public_html
wget -O /home/vps/public_html/index.html "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/index.html1"
/etc/init.d/nginx restart

# install badvpn
cd
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/newudpgw"
chmod +x /usr/bin/badvpn-udpgw
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500' /etc/rc.local
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500

# setting port ssh
cd
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 500' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 40000' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 51443' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 58080' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 200' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 22' /etc/ssh/sshd_config
/etc/init.d/ssh restart

echo "=== Install Dropbear ==="
# install dropbear
apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 50000 -p 109 -p 110 -p 69"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/ssh restart
/etc/init.d/dropbear restart

# Install SSLH
apt -y install sslh
rm -f /etc/default/sslh

# Settings SSLH
cat > /etc/default/sslh <<-END
Default options for sslh initscript
sourced by /etc/init.d/sslh
Disabled by default, to force yourself
to read the configuration:
- /usr/share/doc/sslh/README.Debian (quick start)
- /usr/share/doc/sslh/README, at "Configuration" section
- sslh(8) via "man sslh" for more configuration details.
Once configuration ready, you *must* set RUN to yes here
and try to start sslh (standalone mode only)
RUN=yes
binary to use: forked (sslh) or single-thread (sslh-select) version
systemd users: don't forget to modify /lib/systemd/system/sslh.service
DAEMON=/usr/sbin/sslh
DAEMON_OPTS="--user sslh --listen 0.0.0.0:700 --ssl 127.0.0.1:69 --ssh 127.0.0.1:109 --openvpn 127.0.0.1:1194--pidfile /var/run/sslh/sslh.pid -n"
END

# Restart Service SSLH
service sslh restart
systemctl restart sslh
/etc/init.d/sslh restart
/etc/init.d/sslh status
/etc/init.d/sslh restart

# setting vnstat
apt -y install vnstat
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6

cd
# install stunnel
apt install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 8880
connect = 127.0.0.1:22

[dropbear]
accept = 8443
connect = 127.0.0.1:109

[ws-stunnel]
accept = 444
connect = 700

[openvpn]
accept = 990
connect = 127.0.0.1:1194

END

# make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

# konfigurasi stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

#OpenVPN
wget https://raw.githubusercontent.com/Tarap-Kuhing/tarap/main/ssh/vpn.sh &&  chmod +x vpn.sh && ./vpn.sh

# install fail2ban
apt -y install fail2ban

# Instal DDOS Flate
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'

# banner /etc/issue.net
echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear

# Ganti Banner
wget -O /etc/issue.net "https://raw.githubusercontent.com/Tarap-Kuhing/tarap/main/ssh/issue.net"

#install bbr dan optimasi kernel
#wget https://raw.githubusercontent.com/Tarap-Kuhing/tarap/main/ssh/bbr.sh && chmod +x bbr.sh && ./bbr.sh

# blokir torrent
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

# download script
cd /usr/bin
wget -O addhost "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/addhost.sh"
wget -O slhost "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/slhost.sh"
wget -O about "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/about.sh"
wget -O menu "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/menu.sh"
wget -O addssh "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/addssh.sh"
wget -O trialssh "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/trialssh.sh"
wget -O delssh "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/delssh.sh"
wget -O member "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/member.sh"
wget -O delexp "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/delexp.sh"
wget -O cekssh "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/cekssh.sh"
wget -O restart "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/restart.sh"
wget -O speedtest "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/speedtest_cli.py"
wget -O info "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/info.sh"
wget -O ram "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/ram.sh"
wget -O renewssh "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/renewssh.sh"
wget -O autokill "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/autokill.sh"
wget -O ceklim "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/ceklim.sh"
wget -O tendang "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/tendang.sh"
wget -O clearlog "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/clearlog.sh"
wget -O changeport "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/changeport.sh"
#wget -O portovpn "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/portovpn.sh"
#wget -O portwg "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/portwg.sh"
#wget -O porttrojan "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/porttrojan.sh"
#wget -O portsstp "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/portsstp.sh"
#wget -O portsquid "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/portsquid.sh"
wget -O portvlm "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/portvlm.sh"
wget -O wbmn "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/webmin.sh"
wget -O xp "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/xp.sh"
wget -O swapkvm "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/ssh/swapkvm.sh"
wget -O addvmess "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/xray/addv2ray.sh"
wget -O addvless "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/xray/addvless.sh"
wget -O addtrojan "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/xray/addtrojan.sh"
wget -O addgrpc "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/xray/addgrpc.sh"
wget -O cekgrpc "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/xray/cekgrpc.sh"
wget -O delgrpc "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/xray/delgrpc.sh"
wget -O renewgrpc "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/xray/renewgrpc.sh"
wget -O delvmess "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/xray/delv2ray.sh"
wget -O delvless "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/xray/delvless.sh"
wget -O deltrojan "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/xray/deltrojan.sh"
wget -O cekvmess "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/xray/cekv2ray.sh"
wget -O cekvless "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/xray/cekvless.sh"
wget -O cektrojan "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/xray/cektrojan.sh"
wget -O renewvmess "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/xray/renewv2ray.sh"
wget -O renewvless "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/xray/renewvless.sh"
wget -O renewtrojan "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/xray/renewtrojan.sh"
wget -O certv2ray "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/xray/certv2ray.sh"
wget -O addtrgo "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/trojango/addtrgo.sh"
wget -O deltrgo "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/trojango/deltrgo.sh"
wget -O renewtrgo "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/trojango/renewtrgo.sh"
wget -O cektrgo "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/trojango/cektrgo.sh"

wget -O ipsaya "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/ipsaya.sh"
wget -O sshovpnmenu "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/sshovpn.sh"
wget -O l2tpmenu "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/l2tpmenu.sh"
wget -O pptpmenu "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/pptpmenu.sh"
wget -O sstpmenu "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/sstpmenu.sh"
wget -O wgmenu "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/wgmenu.sh"
wget -O ssmenu "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/ssmenu.sh"
wget -O ssrmenu "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/ssrmenu.sh"
wget -O vmessmenu "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/vmessmenu.sh"
wget -O vlessmenu "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/vlessmenu.sh"
wget -O grpcmenu "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/grpcmenu.sh"
wget -O grpcupdate "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/grpcupdate.sh"
wget -O trmenu "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/trmenu.sh"
wget -O trgomenu "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/trgomenu.sh"
wget -O setmenu "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/setmenu.sh"
wget -O slowdnsmenu "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/slowdnsmenu.sh"
wget -O running "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/running.sh"
wget -O updatemenu "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/update/updatemenu.sh"
#wget -O sl-fix "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/sslh-fix/sl-fix"
wget -O backup "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/backup/backup.sh"
wget -O autobackup "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/backup/autobackup.sh"
wget -O restore "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/backup/restore.sh"
wget -O strt "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/backup/strt.sh"
wget -O limitspeed "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/backup/limitspeed.sh"
#chmod +x sl-fix
chmod +x ipsaya
chmod +x sshovpnmenu
chmod +x l2tpmenu
chmod +x pptpmenu
chmod +x sstpmenu
chmod +x wgmenu
chmod +x ssmenu
chmod +x ssrmenu
chmod +x vmessmenu
chmod +x vlessmenu
chmod +x grpcmenu
chmod +x grpcupdate
chmod +x trmenu
chmod +x trgomenu
chmod +x setmenu
chmod +x slowdnsmenu
chmod +x running
chmod +x updatemenu

chmod +x slhost
chmod +x addhost
chmod +x menu
chmod +x addssh
chmod +x trialssh
chmod +x delssh
chmod +x member
chmod +x delexp
chmod +x cekssh
chmod +x restart
chmod +x speedtest
chmod +x info
chmod +x about
chmod +x autokill
chmod +x tendang
chmod +x ceklim
chmod +x ram
chmod +x renewssh
chmod +x clearlog
chmod +x changeport
chmod +x portovpn
chmod +x portwg
chmod +x porttrojan
chmod +x portsstp
chmod +x portsquid
chmod +x portvlm
chmod +x wbmn
chmod +x xp
chmod +x swapkvm
chmod +x addvmess
chmod +x addvless
chmod +x addtrojan
chmod +x addgrpc
chmod +x delgrpc
chmod +x delvmess
chmod +x delvless
chmod +x deltrojan
chmod +x cekgrpc
chmod +x cekvmess
chmod +x cekvless
chmod +x cektrojan
chmod +x renewgrpc
chmod +x renewvmess
chmod +x renewvless
chmod +x renewtrojan
chmod +x certv2ray
chmod +x addtrgo
chmod +x deltrgo
chmod +x renewtrgo
chmod +x cektrgo
chmod +x backup
chmod +x autobackup
chmod +x restore
chmod +x strt
cd

cat > /etc/cron.d/re_otm <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 2 * * * root /sbin/reboot
END

cat > /etc/cron.d/xp_otm <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 0 * * * root /usr/bin/xp
END

cat > /home/re_otm <<-END
7
END

service cron restart >/dev/null 2>&1
service cron reload >/dev/null 2>&1

# remove unnecessary files
sleep 0.5
echo -e "[ ${green}INFO$NC ] Clearing trash"
apt autoclean -y >/dev/null 2>&1

if dpkg -s unscd >/dev/null 2>&1; then
apt -y remove --purge unscd >/dev/null 2>&1
fi

apt-get -y --purge remove samba* >/dev/null 2>&1
apt-get -y --purge remove apache2* >/dev/null 2>&1
apt-get -y --purge remove bind9* >/dev/null 2>&1
apt-get -y remove sendmail* >/dev/null 2>&1
apt autoremove -y >/dev/null 2>&1
# finishing
cd
chown -R www-data:www-data /home/vps/public_html
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/cron restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/sslh restart
/etc/init.d/stunnel5 restart
/etc/init.d/vnstat restart
/etc/init.d/fail2ban restart
/etc/init.d/squid restart

screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500
history -c
echo "unset HISTFILE" >> /etc/profile

cd
rm -f /root/key.pem
rm -f /root/cert.pem
rm -f /root/ssh-vpn.sh

# finihsing
clear
