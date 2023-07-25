# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear

# This script configures USB connection upon detection of an
# external USB connection made to the device.

/bin/sleep 1

count=0

while [ $count -lt 70 ] ; do
    PID=`cat /sys/kernel/config/usb_gadget/g1/idProduct`
    UDC=`cat /sys/kernel/config/usb_gadget/g1/UDC`
    connection_state=`cat /sys/class/android_usb/android0/state`

    if [ "$connection_state" ==  "CONFIGURED" ]; then
       if [ "$PID" == "0x908c" ]; then
            if [ "$UDC" == "a600000.dwc3" ]; then
                 ifconfig usb0 192.168.1.20 netmask 255.255.255.0
                 echo "USB Configured"
            else
                 echo "UDC not set to a600000.dwc3"
            fi
           else
           echo "PID is not 0x908c"
        fi
        break
    else
        /bin/sleep 0.1
        continue
    fi

    count=`expr $count + 1`
done

exit 0
