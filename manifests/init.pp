
# Main class to set up LLDP and check if network devices are ready to get LLDP.
#
# Usage: (Simple example to invoke only for physical machines)
#
# if $::virtual == 'physical' {
#   include lldp
# }


class lldp {

   package { 'lldpad':
      ensure => present
   }

   service { 'lldpad':
      enable     => true,
      ensure     => running,
      require    => Package['lldpad'],   
   }

   file { '/usr/local/bin/lldp_enable.sh':
      owner   => 'root',
      group   => 'root',
      mode    => '0744',
      source  => 'puppet:///modules/lldp/lldp_enable.sh',
      require => Package['lldpad'],   
   }   

   exec { 'Check_lldp':
      command => '/usr/local/bin/lldp_enable.sh',
      require => File['/usr/local/bin/lldp_enable.sh'],
      path    => ['/usr/bin', '/usr/local/bin', '/bin', '/usr/sbin/'],
      onlyif  => "test `lldptool get-lldp -i eth0 adminStatus | cut -d'=' -f2` != 'rxtx' || test `lldptool get-lldp -i eth1 adminStatus | cut -d'=' -f2` != 'rxtx'",
      user    => 'root',

   }

}
