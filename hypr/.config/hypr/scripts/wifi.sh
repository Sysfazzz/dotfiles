#!/bin/bash

notify-send -t 3000 "Wi-Fi" "Fetching Wi-Fi Access Points..."
networks=$(nmcli -t -f SSID device wifi list | grep -v "^$" | sort -u)
chosen_network=$(echo "$networks" | rofi -dmenu -i -p "Wi-Fi:" -theme ~/.config/rofi/wifi.rasi)

if [ -z "$chosen_network" ]; then
    exit
fi

saved_connections=$(nmcli -g NAME connection)

if echo "$saved_connections" | grep -qw "$chosen_network"; then
    notify-send -t 3000 "Wi-Fi" "Connecting to $chosen_network..."
    
    if nmcli connection up id "$chosen_network"; then
        notify-send -t 3000 "Wi-Fi" "Connected to $chosen_network!"
    else
        notify-send -u critical -t 3000 "Wi-Fi Error" "Failed to connect. Forgetting network..."
        nmcli connection delete "$chosen_network"
    fi
else
    password=$(rofi -dmenu -p "Password:" -password -theme ~/.config/rofi/wifi.rasi -theme-str 'mainbox { children: [ inputbar ]; }')
    
    if [ -n "$password" ]; then
        notify-send -t 3000 "Wi-Fi" "Connecting to $chosen_network..."

        if nmcli device wifi connect "$chosen_network" password "$password"; then
            notify-send -t 3000 "Wi-Fi" "Connected to $chosen_network!"
        else
            notify-send -u critical -t 3000 "Wi-Fi Error" "Wrong password or connection failed."
            nmcli connection delete "$chosen_network"
        fi
    fi
fi