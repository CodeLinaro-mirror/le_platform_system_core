# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear

# This script configures USB connection upon detection of an
# external USB connection made to the device.

/bin/sleep 1

count=0

while [ $count -lt 50 ] ; do
    PID=`cat /sys/kernel/config/usb_gadget/g1/idProduct`
    UDC=`cat /sys/kernel/config/usb_gadget/g1/UDC`
    connection_state=`cat /sys/class/android_usb/android0/state`

    if [ $1 == "usb1" ]; then
        if [ "$connection_state" ==  "CONFIGURED" ] && [ "$PID" == "0x9131" ] && [ "$UDC" == "a600000.dwc3" ]; then
                    ifconfig usb0 192.168.1.20 netmask 255.255.255.0
                    echo "USB Configured"
                    break
        else
            /bin/sleep 0.1
            count=`expr $count + 1`
            continue
        fi
    else
        if [ "$connection_state" ==  "DISCONNECTED" ] && [ "$PID" == "0x9131" ] && [ "$UDC" == "a600000.dwc3" ]; then
                    ifconfig usb0 0.0.0.0
                    echo "USB Configured"
                    break
        else
            /bin/sleep 0.1
            count=`expr $count + 1`
            continue
        fi
    fi
done

exit 0
