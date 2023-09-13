#! /bin/bash

# Description: Radius – Authentication
# Author: 网管小贾 / sysadm.cc
# Type: External check
# Key: checkradius.sh[]
# Type of information: Numeric (unsigned)

timelimit -T 1 -t 1 eapol_test -c /yourpath/eap-peap.conf -a 192.168.1.123 -p 1812 -s testing123
