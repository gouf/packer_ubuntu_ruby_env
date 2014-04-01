#
# Cookbook Name:: deployer
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user 'deployer' do
  home '/home/deployer'
  shell '/bin/bash'
  password nil
  supports manage_home: true
end

group "admin" do
  members "deployer"
  action :create
end


directory '/home/deployer/.ssh' do
  owner 'deployer'
  group 'admin'
  mode 00700
  action :create
end

remote_file "aws.pub key file" do
  source "https://s3-ap-northeast-1.amazonaws.com/static.inn0centzero.com/aws.pub"
  path "/home/deployer/.ssh/authorized_keys"
end

file "/home/deployer/.ssh/authorized_keys" do
  owner 'deployer'
  group 'admin'
  #group 'vagrant'
  only_if { ::File.exists? '/home/deployer/.ssh/authorized_keys' }
end

ruby_block 'edit /home/deployer/.bashrc' do
  block do
    regex = %r(^export RBENV_ROOT=/usr/local/rbenv$)
    text  = <<EOF
export RBENV_ROOT=/usr/local/rbenv
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"
EOF
    path  = '/home/deployer/.bashrc'
    `touch #{path}` if File.exists? path
    if File.readlines(path).grep(regex).size == 0
      File.open(path, 'a').write text
    end
  end
end
