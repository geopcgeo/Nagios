# Class: nagios::params
#
# Sets internal variables and defaults for nagios module
# This class is automatically loaded in all the classes that use the values set here 
#
class nagios::params  {


   # Sets Nagios versions according to default package of different OS. To be updated...
    $version = $operatingsystem ? {
        redhat  => "2",
        centos  => "2",
        debian  => "2",
        default => "3",
    }
    
    $username = $operatingsystem ? {
        default => "nagios",
    } 

  
## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        ubuntu  => "nagios3",
        debian  => "nagios2",
        default => "nagios",
    }

    $servicename = $operatingsystem ? {
        ubuntu  => "nagios3",
        debian  => "nagios2",
        default => "nagios",
    }

    $processname = $operatingsystem ? {
        ubuntu  => "nagios3",
        debian  => "nagios2",
        default => "nagios",
    }

    $hasstatus = $operatingsystem ? {
        default => true,
    }

    $configfile = $operatingsystem ? {
        ubuntu  => "/etc/nagios3/nagios.cfg",
        debian  => "/etc/nagios2/nagios.cfg",
        default => "/etc/nagios/nagios.cfg",
    }

    $configfile_mode = $operatingsystem ? {
        default => "644",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        default => "root",
    }

    $configdir = $operatingsystem ? {
        debian  => "/etc/nagios2",
        ubuntu  => "/etc/nagios3",
        default => "/etc/nagios",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/nagios2",
        ubuntu  => "/etc/default/nagios3",
        default => "/etc/sysconfig/nagios",
    }
    
    
}
