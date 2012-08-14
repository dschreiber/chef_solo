case platform 
when "ubuntu","debian"
  default[:ntp][:service] = "ntp"
when "redhat","centos","fedora", "amazon"
  default[:ntp][:service] = "ntpd"
end

default[:ntp][:is_server] = false
default[:ntp][:servers]   = ["0.us.pool.ntp.org", "1.us.pool.ntp.org"]
