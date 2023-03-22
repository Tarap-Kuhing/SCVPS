#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
# Link Hosting Kalian
"https://github.com/Tarap-Kuhing/SCVPS/tree/main/backup"

apt install rclone -y
printf "q\n" | rclone config
wget -O /root/.config/rclone/rclone.conf "https://raw.githubusercontent.com/Tarap-Kuhing/SCVPS/main/backup/rclone.conf"
git clone  https://github.com/Tarap-Kuhing/SCVPS/tree/main/backup
cd wondershaper
make install
cd
rm -rf wondershaper
echo > /home/limit
apt install msmtp-mta ca-certificates bsd-mailx -y
cat<<EOF>>/etc/msmtprc
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account default
host smtp.gmail.com
port 587
auth on
user bckupvpns@gmail.com
from bckupvpns@gmail.com
password Yangbaru1
logfile ~/.msmtp.log
EOF
chown -R www-data:www-data /etc/msmtprc
cd /usr/bin
wget -O autobackup "https://github.com/Tarap-Kuhing/SCVPS/tree/main/backup/autobackup.sh"
wget -O backup "https://github.com/Tarap-Kuhing/SCVPS/tree/main/backup/backup.sh"
wget -O restore "https://github.com/Tarap-Kuhing/SCVPS/tree/main/backup/restore.sh"
wget -O strt "https://github.com/Tarap-Kuhing/SCVPS/tree/main/backup/strt.sh"
wget -O limitspeed "https://github.com/Tarap-Kuhing/SCVPS/tree/main/backup/limitspeed.sh"
chmod +x autobackup
chmod +x backup
chmod +x restore
chmod +x strt
chmod +x limitspeed
cd
rm -f /root/set-br.sh
