#
# Cookbook Name:: frontend
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "iptables"

node.default['iptables']['http_80'] = '-A FWR -p tcp -m tcp --dport 80 -j ACCEPT'
node.default['iptables']['db_upstream_3306'] = '-A FWR -p tcp -m tcp --dport 3306 -j ACCEPT'


package 'nginx' do
  action :install
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  mode '0440'
  owner 'root'
  group 'root'
  notifies :restart, 'service[nginx]'
end

service 'nginx' do
  action [ :enable, :start ]
end


