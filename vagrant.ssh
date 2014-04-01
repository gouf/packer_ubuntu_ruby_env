#!/bin/sh

set -ex

# password-less login
mkdir ~/.ssh
chmod 0700 ~/.ssh
wget -qO- https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub > ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

# password-less sudo
echo 'vagrant' | sudo -S sh -c "echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant"
echo 'vagrant' | sudo -S chmod 0440 /etc/sudoers.d/vagrant
