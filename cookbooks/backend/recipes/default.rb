#
# Cookbook Name:: backend
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "iptables"
node.default['iptables']['mysql_3306'] = '-A FWR -p tcp -m tcp --dport 3306 -j ACCEPT'

mysql_service 'default' do
  bind_address '0.0.0.0'
  port '3306'
  data_dir '/data'
  initial_root_password 'Ch4ng3me'
  action [:create, :start]
end
