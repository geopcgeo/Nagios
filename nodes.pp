
Exec { 
    path => ["/bin", "/sbin", "/usr/bin", "/usr/sbin"], 
}


node default {
	include nagios
	include apache
}
