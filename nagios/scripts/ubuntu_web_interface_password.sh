#!/bin/sh
#This will create password for the user nagiosadmin.
nagiosadmin_password=$1
echo "Configuring Nagios Web Interface Login"
htpasswd -b -c /etc/nagios3/htpasswd.users nagiosadmin $nagiosadmin_password
sudo /etc/init.d/nagios3 restart
sudo /etc/init.d/nagios-nrpe-server restart
sudo /etc/init.d/apache2 restart
echo "Now you can login to Nagios Web Interface with url http://<IP Address>/nagios3/ with username nagiosadmin."
