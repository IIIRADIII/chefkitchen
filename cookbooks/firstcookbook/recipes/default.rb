#
# Cookbook Name:: firstcookbook
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "iptables"
include_recipe "apt"
include_recipe "ntp"

node.default['iptables']['ssh_22'] = '-A FWR -p tcp -m tcp --dport 22 -j ACCEPT'

users_manage "wheel" do
   action [ :remove, :create ]
   data_bag 'users'
end

node.default['authorization']['sudo']['users'] = ['chefuser','vagrant']
node.default['authorization']['sudo']['passwordless']  = true
include_recipe "sudo"


ruby_block "Disable for ssh login with pasword" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/ssh/sshd_config")
    fe.search_file_replace("PasswordAuthentication yes",
                               "PasswordAuthentication no")
    fe.write_file
  end
end
service 'ssh' do
  action :restart
end

for p in ['htop','iotop','tcpdump','git','wget','vim','sysstat'] do
  package p do
    action [:install]
  end
end

cookbook_file '/etc/motd' do
  source 'motd'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
