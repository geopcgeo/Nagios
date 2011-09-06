# Class: apache::debian
#
# Debian specific settings for apache class
# This class is included by main apache class, it's not necessary to call it directly
#
class apache::debian {
	
	exec { "mod-rewrite-on":
		command =>"a2enmod rewrite",
		require => Service ["apache2"]
		}
# Quick'n'dirt fix for logs directory in apache::virtualhost base template
	file { "Apache_loglink":
        path   => "/etc/apache2/logs",
        ensure => "/var/log/apache2/",
        require => Package["apache"],
    }
}

