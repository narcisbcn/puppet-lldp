# Facter to discover neighbor bridges

begin
    Facter.interfaces
rescue
    Facter.loadfacts()
end

Facter.value(:interfaces).split(',').each do |interface|
   if interface =~ /^eth\d+$/    
       Facter.add("switch_port_#{interface}") do
           confine :kernel => :linux, :operatingsystem => %w{CentOS Fedora RedHat}
           setcode do
              result=Facter::Util::Resolution.exec("lldptool -t -V portDesc -n -i #{interface} | tail -n1 | awk '{print $1}'" )
              if $?.exitstatus == 0
                result
              end
           end
        end
   end
end


Facter.value(:interfaces).split(',').each do |interface|
   if interface =~ /^eth\d+$/    
       Facter.add("switch_name_#{interface}") do
           confine :kernel => :linux, :operatingsystem => %w{CentOS Fedora RedHat}
           setcode do
              result=Facter::Util::Resolution.exec("lldptool -t -V sysname -n -i #{interface} | tail -n1 | awk '{print $1}'" )
              if $?.exitstatus == 0
                result
              end
           end
        end
   end
end



