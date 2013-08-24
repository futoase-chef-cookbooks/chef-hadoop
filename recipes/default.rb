#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2013, Keiji Matsuzaki
#
# All rights reserved - Do Not Redistribute
#

user "hadoop" do
  home     "/home/hadoop"
  shell    "/bin/bash"
  supports :manage_home => true
  action   :create
end

remote_file "#{Chef::Config[:file_cache_path]}/hadoop.tar.gz" do
  owner  "hadoop"
  group  "hadoop"
  source "http://apache.mirrors.hoobly.com/hadoop/common/hadoop-1.2.0/hadoop-1.2.0.tar.gz"
end

directory "/home/hadoop/local" do
  user  "hadoop"
  group  "hadoop"
  action :create
end

bash "install-hadoop" do
  cwd   "/home/hadoop/local"

  user  "hadoop"
  group "hadoop"

  code <<-EOC
    tar -xvzf #{Chef::Config[:file_cache_path]}/hadoop.tar.gz 
  EOC
end

bash "setup bash_profile" do
  cwd   "/home/hadoop"

  user  "hadoop"
  group "hadoop"

  code <<-EOC
    echo "export PATH=/home/hadoop/local/hadoop-1.2.0/bin:$PATH" >> .bash_profile
  EOC
end
