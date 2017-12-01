#!/bin/bash
BUSNUM=1
DEVNUM=2
DOMAIN=centos6.9
COMMAND=attach-device
XMLFILE=".pi_virsh.xml"
cat > "/tmp/${XMLFILE}" << EOF
<hostdev mode='subsystem' type='usb' managed='yes'>
  <source>
    <vendor id='0x0bd7'/>
    <product id='0xa026'/>
  </source>
</hostdev>
EOF

echo "Running virsh ${COMMAND} ${DOMAIN} for USB bus=${BUSNUM} device=${DEVNUM}:" >&2
#    <!--<address type='usb' bus='${BUSNUM}' device='${DEVNUM}' />-->
# <address type='usb' bus='0' port='4'/>
# \ref https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=846173
if [ "$ACTION" = "add" ]; then
	systemd-run  --on-active=1 --timer-property=AccuracySec=100ms virsh detach-device centos6.9 /tmp/${XMLFILE}
	systemd-run  --on-active=3 --timer-property=AccuracySec=100ms virsh attach-device centos6.9 /tmp/${XMLFILE}
fi
#virsh "${COMMAND}" "${DOMAIN}"  "/tmp/${XMLFILE}"
#/dev/stdin << END
#<hostdev mode='subsystem' type='usb' managed='yes'>
#  <source>
#    <vendor id='0x0bd7'/>
#    <product id='0xa026'/>
#  </source>
#</hostdev>
#END

