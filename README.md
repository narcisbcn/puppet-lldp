puppet-lldp
===========

Overview
--------

Link Layer Discovery Protocol aka LLDP is useful to discover neighbors connected on your servers. This module will install lldptool binary to find out the name and port of the switch where your server is connected on.

Environment

- Tested with RedHat OS family upper or equal than version 6
- Enable LLDP feature on each switch

Usage:
------

If you want to deploy this feature on each server you can use facts to filter cases as follows:

<pre>
if $::virtual == 'physical' and $::operatingsystem == 'CentOS' and $::operatingsystemrelease =~ /^6/ {
   include lldp
}
</pre>


Ouptut Example:
---------------

<pre>
switch_name_eth0 => N5K1
switch_name_eth1 => N5K2
switch_port_eth0 => Ethernet116/1/22
switch_port_eth1 => Ethernet117/1/22
</pre>

