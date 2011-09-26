#!/bin/sh
#This will create password for the user nagiosadmin.
nagiosadmin_password=$1
echo "Configuring Nagios Web Interface Login"
htpasswd -b -c /etc/nagios/htpasswd.users nagiosadmin $nagiosadmin_password
/etc/init.d/nagios restart
/etc/init.d/nrpe start
chkconfig nrpe on
/etc/init.d/httpd restart
echo "Now you can login to Nagios Web Interface with url http://<IP Address>/nagios/ with username nagiosadmin."
