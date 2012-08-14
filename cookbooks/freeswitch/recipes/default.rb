#
# Cookbook Name:: freeswitch
# Recipe:: default
#
# Copyright 2010, 2600hz 
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

packages = value_for_platform(
	[ "centos", "redhat", "fedora", "suse" ] => {
	  "default" => %w(unzip mysql-server curl-devel ncurses-devel ncurses-devel e2fsprogs-libs glibc libgcrypt openssl openssl-devel zlib zlib-devel libgcc libogg libogg-devel libidn libstdc++ libjpeg postgresql-libs gnutls gnutls-devel expat-devel libtiff libtiff-devel libtheora libtheora-devel alsa-lib alsa-lib-devel unixODBC unixODBC-devel libvorbis libvorbis-devel)
	},
	[ "ubuntu", "debian"] => {
	  "default" => %w( libasound2  libogg0 libvorbis0a autoconf libncurses5-dev debconf-utils vim unixODBC strace unixODBC-dev libtiff4 libtiff4-dev libtool)
	},
	"default" => %w{libtiff libtiff-devel libtheora libtheora-devel alsa-lib alsa-lib-devel unixODBC unixODBC-devel libvorbis libvorbis-devel}
)

packages.each do |pkg|
	package pkg do
	  action :upgrade
	end
end

if platform?("centos", "redhat", "fedora", "suse")
  script "install_freeswitch" do
	not_if { ::FileTest.exists?("/opt/freeswitch/bin/fs_cli") }
	interpreter "bash"
	user "root"
	cwd "/usr/src"	
	code <<-EOH
		svn "path to freeswitch rpms"
		rpm -Uvh "freeswitch rpms"
 	 EOH
  end
else
  script "install_freeswitch" do
        not_if { ::FileTest.exists?("/opt/freeswitch/bin/fs_cli") }
        interpreter "bash"
        user "root"
        cwd "/usr/src"
        code <<-EOH
		svn "path to freeswitch debs"
                dpkg -i /usr/src/"freeswitch debs"
         EOH
  end
end
