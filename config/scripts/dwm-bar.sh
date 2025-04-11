#!/usr/bin/env bash

while true; do
    time=$(date '+%Y-%m-%d %T')

    battery_info=$(acpi -b)

    battery_percentage=$(echo "$battery_info" | grep -oP '\d+(?=%)')

    battery_status=$(echo "$battery_info" | grep -oP '(Discharging|Charging)')

    if [[ "$battery_status" == "Discharging" ]]; then
        stat="D"
        status="$battery_percentage%"
    else
        stat="C"
        status="$battery_percentage%"
    fi

    if [[ -n "$iface" && "$(cat /sys/class/net/$iface/operstate)" == "up" ]]; then
        net_status="Online"
    else
        net_status="Offline"
    fi

    full_status="$net_status | BAT($stat): $status | $time"

    xsetroot -name "$full_status"

    sleep 1
done
