#!/bin/bash

# DO NOT EDIT IT: File managed by puppet 
# It checks if all network interfaces starting by eth have LLDP enabled, if not activates it.

for dev in `ls /sys/class/net`; do

   if [[ ${dev} == eth* ]]; then
      if [[ `lldptool get-lldp -i $dev adminStatus | cut -d'=' -f2` != 'rxtx' ]]; then
         lldptool -L -i $dev adminStatus=rxtx
      fi
   fi

done
