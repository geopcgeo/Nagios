# Class: apache::params
#
# Defines apache parameters
# In this class are defined as variables values that are used in other users classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class apache::params  {
## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
#

# EXTRA VARIABLES
    $vdir = $operatingsystem ? {
        freebsd => "/usr/local/etc/apache20/conf.d",
        ubuntu  => "/etc/apache2/sites-available",
        debian  => "/etc/apache2/sites-available",
        centos  => "/etc/httpd/conf.d",
        redhat  => "/etc/httpd/conf.d",
    }

# MODULES INTERNAL VARIABLES
# (Modify only to adapt to unsupported OSes)
    $packagename = $operatingsystem ? {
        freebsd => "apache20",
        debian  => "apache2",
        ubuntu  => "apache2",
        default => "httpd",
    }

    $servicename = $operatingsystem ? {
        debian  => "apache2",
        ubuntu  => "apache2",
        default => "httpd",
    }

    $servicepattern = $operatingsystem ? {
        debian  => "/usr/sbin/apache2",
        ubuntu  => "/usr/sbin/apache2",
        default => "/usr/sbin/httpd",
    }

    $processname = $operatingsystem ? {
        debian  => "apache2",
        ubuntu  => "apache2",
        default => "httpd",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $username = $operatingsystem ? {
        debian  => "www-data",
        ubuntu  => "www-data",
        default => "apache",
    }

    $configfile = $operatingsystem ? {
        freebsd => "/usr/local/etc/apache20/httpd.conf",
        ubuntu  => "/etc/apache2/apache2.conf",
        debian  => "/etc/apache2/apache2.conf",
        default => "/etc/httpd/conf/httpd.conf",
    }

    $configfile_mode = $operatingsystem ? {
        default => "644",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        freebsd => "wheel",
        default => "root",
    }

    $configdir = $operatingsystem ? {
        freebsd => "/usr/local/etc/apache20",
        ubuntu  => "/etc/apache2",
        debian  => "/etc/apache2",
        default => "/etc/httpd/conf",
    }

    $documentroot = $operatingsystem ? {
        debian  => "/var/www",
        ubuntu  => "/var/www",
        suse    => "/srv/www",
        default => "/var/www/html",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/apache2",
        ubuntu  => "/etc/default/apache2",
        default => "/etc/sysconfig/httpd",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        ubuntu  => "/var/run/apache2.pid",
        debian  => "/var/run/apache2.pid",
        default => "/var/run/httpd.pid",
    }

	$virtualhostconf = $operatingsystem ? {
		ubuntu  => "/etc/apache2/sites-available/default",
		centos  => "/etc/httpd/conf/httpd.conf",
		default => "/etc/httpd/conf/httpd.conf",
	}
	
	
}

