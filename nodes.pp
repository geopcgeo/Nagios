$check_external_commands=yes
$link = "yes"
$monitor = "yes"
$firewall = "yes"
$my_project_onmodule = "no"
$plugins = "yes"
$use_ssl = "no"

Exec { 
    path => ["/bin", "/sbin", "/usr/bin", "/usr/sbin"], 
}


node default {
	include nagios
	include apache
}
