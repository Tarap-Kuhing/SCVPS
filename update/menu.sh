#!/bin/bash
clear
m="\033[0;1;36m"
y="\033[0;1;37m"
yy="\033[0;1;32m"
yl="\033[0;1;33m"
wh="\033[0m"
echo -e "\033[0;36m==================================================\033[m"
echo -e   "\E[44;1;39m              ⇱ MENU UTAMA ⇲                      \E[0m"
echo -e   "\E[44;1;39m            ⇱ SC VPS PREMIUM ⇲                    \E[0m"
 echo -e "\033[0;36m==================================================\033[m"
echo -e   "$yy  1. •SSH & OpenVPN MENU                              $wh"
echo -e   "$yy  2. •L2TP MENU                                       $wh"
echo -e   "$yy  3. •PPTP MENU                                       $wh"
echo -e   "$yy  4. •SSTP MENU                                       $wh"
echo -e   "$yy  5. •WIREGUARD MENU                                  $wh"
echo -e   "$yy  6. •SHADOWSOCKS MENU                                $wh"
echo -e   "$yy  7. •SHADOWSOCKSR MENU                               $wh"
echo -e   "$yy  8. •XRAY VMESS MENU                                 $wh"
echo -e   "$yy  9. •XRAY VLESS MENU                                 $wh"
echo -e   "$yy 10. •XRAY TROJAN MENU                                $wh"
echo -e   "$yy 11. •TROJAN GO MENU                                  $wh"
echo -e   "$yy 12. •XRAY GRPC MENU                                  $wh"  
echo -e   "$yy 13. •SLOWDNS MENU (OFF)                              $wh"
echo -e   "$yy 14. •CEK SEMUA IP PORT                               $wh"
echo -e   "$yy 15. •CEK SEMUA SERVICE VPN                           $wh"
echo -e   "$yy 16. •UPDATE MENU (Update 2x)                         $wh"
echo -e   "$yy 17. •SL-FIX (Perbaiki Error SSLH+WS-TLS)             $wh"
echo -e   "$yy 18. •SETTING (Pengaturan)                            $wh"
echo -e   "$yy 19. •Exit (Keluar)                                   $wh"
echo -e   "$yy 20. •COPY REPO (Salin Repo Script Tarap Kuhing)      $wh"
echo -e   "$yy 21. •MENU INFO (Untuk Mendapatkan Informasi)         $wh"
echo -e   "$yy 22. •GRPC MENU2 (GRPC BARU)                          $wh"
echo -e "\033[0;36m==================================================\033[m"
echo -e   "\E[44;1;39m           ⇱ MOD BY TARAP KUHING ⇲                \E[0m"
echo -e   "\E[44;1;39m            ⇱ WA : 085754292950 ⇲                 \E[0m"
echo -e "\033[0;36m==================================================\033[m"
read -p "Select From Options [ 1 - 22 ] : " menu
case $menu in
1)
clear
sshovpnmenu
;;
2)
clear
l2tpmenu
;;
3)
clear
pptpmenu
;;
4)
clear
sstpmenu
;;
5)
clear
wgmenu
;;
6)
clear
ssmenu
;;
7)
clear
ssrmenu
;;
8)
clear
vmessmenu
;;
9)
clear
vlessmenu
;;
10)
clear
trmenu
;;
11)
clear
trgomenu
;;
12)
clear
grpcmenu
;;
13)
clear
slowdnsmenu
;;
14)
clear
ipsaya
;;
15)
clear
running
;;
16)
clear
updatemenu
;;
17)
clear
sl-fix
;;
18)
clear
setmenu
;;
19)
clear
exit
;;
20)
clear
copyrepo
;;
21)
clear
menuinfo
;;
22)
clear
grpcmenu2
;;
*)
clear
menu
;;
esac
