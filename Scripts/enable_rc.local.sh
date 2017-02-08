#!/bin/bash
########################################################################
# This script is for OviOS Linux 2.x
# Roberto Alvarado <ralvarado@anycast.cl>
# Description: Add support for rc.local
# Version     : 1.0
########################################################################

cat <<EOF > /etc/init.d/rc.local
#!/bin/sh
########################################################################
# This script is for OviOS Linux 2.x
# Roberto Alvarado <ralvarado@anycast.cl>
# Description: Add support for rc.local execution on system start
# Version     : 1.0
########################################################################

PATH=/bin:/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin

. /lib/lsb/init-functions

do_start() {
        if [ -x /etc/rc.local ]; then
                /etc/rc.local
        fi
}

case "$1" in
    start)
        do_start
        ;;
    restart|reload|force-reload)
        echo "Error: argument '$1' not supported" >&2
        exit 3
        ;;
    stop)
        ;;
    *)
        echo "Usage: $0 start|stop" >&2
        exit 3
        ;;
esac
EOF
chmod +x /etc/init.d/rc.local
cat <<EOF > /etc/rc.local
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

exit 0
EOF

# Setup init levels
for i in 2 3 4 5; do ln -s ../init.d/rc.local  /etc/rc.d/rc$i.d/S99rc.local ; done
#
echo "Done"
echo "For enable the execution of rc.local file, dont forget to do: chmod +x /etc/rc.local"
