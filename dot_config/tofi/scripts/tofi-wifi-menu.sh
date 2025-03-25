#!/bin/bash

# Check for required programs
for cmd in nmcli zenity expect; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "$cmd is required but not installed."
        exit 1
    fi
done

# Scan Wi-Fi networks
scan_wifi() {
    nmcli -t -f SSID device wifi list
}

# Main
while true; do
    # Scan for available Wi-Fi networks
    wifi_list=$(scan_wifi)

    # Display Wi-Fi menu
    selected_wifi=$(echo "$wifi_list" | tofi -c ~/.config/tofi/configN) # Replace with your own config
    
    # Extract SSID
    ssid=$(echo "$selected_wifi")

    # Check if the network is already saved
    if nmcli connection show --active | grep -q "$ssid"; then
        # Already connected to the network
        echo "Already connected to $ssid. Skipping password prompt."
        break
    elif nmcli connection show | grep -q "$ssid"; then
        # Network is saved but not connected; connect without prompting
        nmcli connection up "$ssid"
        if [ $? -eq 0 ]; then
            echo "Connected to saved network: $ssid."
            break
        else
            echo "Failed to connect to saved network: $ssid."
        fi
    fi

    while true; do
        # Prompt for password using zenity
        password=$(zenity --password --title "Wi-Fi Password" --text "Enter the Wi-Fi password for SSID: $ssid")
        # Exit if no password is entered
        if [ -z "$password" ]; then
            echo "No password entered. Exiting."
            exit 1
        fi

        # Use expect to handle the nmcli input
        expect <<EOF
            spawn nmcli device wifi connect "$ssid" --ask
            expect "Password (802-11-wireless-security.psk):"
            send -- "$password\r"
            expect eof
EOF

        # Check connection status
        nmcli -t -f ACTIVE,SSID dev wifi | awk -F':' -v ssid="$ssid" '$1 == "yes" && $2 == ssid { found=1 } END { exit !found }'
        if [ $? -eq 0 ]; then
            echo "Successfully connected to $ssid."
            break 2  # Exit both inner and outer loops
        else
            echo "Failed to connect to $ssid."
	    # We need to delete the saved network profile because it will be saved with the wrong password if the password entered was wrong.
            nmcli connection delete id "$ssid"
            echo "Saved profile for $ssid has been removed. Retrying..."
        fi
    done
done

