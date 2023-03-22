#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
colornow=$(cat /etc/tarap/theme/color.conf)
NC="\e[0m"
RED="\033[0;31m"
COLOR1="$(cat /etc/tarap/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/tarap/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
WH='\033[1;37m'
###########- END COLOR CODE -##########
clear
source /var/lib/crot/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
tls="$(cat ~/log-install.txt | grep -w "Vless WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless WS none TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}            ${WH}• Add Vless Account •              ${NC} $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"

		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
		echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
		echo -e "$COLOR1 ${NC} ${COLBG1}            ${WH}• Add Vless Account •              ${NC} $COLOR1 $NC"
		echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			read -n 1 -s -r -p "Press any key to back on menu"
			v2ray-menu
		fi
	done
read -p "   Bug SNI/Host : " sni

uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vless$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
vlesslink1="vless://${uuid}@${domain}:$tls?path=/vless&security=tls&encryption=none&host=$sni&type=ws&sni=$sni#${user}"
vlesslink2="vless://${uuid}@${domain}:80?path=/vless&security=none&encryption=none&host=$sni&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:$tls?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=$sni#${user}"
systemctl restart xray
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${COLBG1}           ${WH}• CREATE VLESS USER •               ${NC} $COLOR1 $NC" | tee -a /etc/log-create-user.log
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} "
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${WH}Remarks      ${COLOR1}: ${WH}${user}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}Domain       ${COLOR1}: ${WH}${domain}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}Wildcard     ${COLOR1}: ${WH}(bug.com).${domain}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}Port TLS     ${COLOR1}: ${WH}$tls" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}Port none TLS${COLOR1}: ${WH}80,8080" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}id           ${COLOR1}: ${WH}${uuid}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}Encryption   ${COLOR1}: ${WH}none" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}Network      ${COLOR1}: ${WH}ws" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}Path         ${COLOR1}: ${WH}/vless" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}Path         ${COLOR1}: ${WH}vless-grpc" | tee -a /etc/log-create-user.log
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} "
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLOR1}Link Websocket TLS      ${WH}:${NC}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}${vlesslink1}${NC}"  | tee -a /etc/log-create-user.log
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLOR1}Link Websocket non TLS  ${WH}:${NC}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}${vlesslink2}${NC}"  | tee -a /etc/log-create-user.log
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLOR1}Link gRPC               ${WH}:${NC}" | tee -a /etc/log-create-user.log
echo -e "$COLOR1 ${NC} ${WH}${vlesslink3}${NC}"  | tee -a /etc/log-create-user.log
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${WH}Expired On   ${COLOR1}: ${WH}$exp" | tee -a /etc/log-create-user.log
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1 ${NC}"
echo -e "$COLOR1┌────────────────────── ${WH}BY${NC} ${COLOR1}───────────────────────┐${NC}"
echo -e "$COLOR1 ${NC}                ${WH}• TARAP KUHING •${NC}                 $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
read -n 1 -s -r -p "Press any key to back on menu"
menu
