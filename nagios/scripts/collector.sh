#!/bin/bash


echo "command[check_mysql]=/usr/lib/nagios/plugins/check_mysql -u nagios -p nagios"  >>  /etc/nagios/nrpe.cfg

echo "command[check_http]=/usr/lib/nagios/plugins/check_http -w 10 -c 15 alim.org"  >>  /etc/nagios/nrpe.cfg

sudo /etc/init.d/nagios3 restart
sudo /etc/init.d/nagios-nrpe-server restart
sudo /etc/init.d/afcollector restart

echo "All commands executed successfully. Now you can login to AppFirst  and check polled data's."

