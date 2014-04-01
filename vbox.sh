#!/bin/bash

mkdir /tmp/isomount
sudo mount -t iso9660 -o loop ~/VBoxGuestAdditions.iso /tmp/isomount

sudo /tmp/isomount/VBoxLinuxAdditions.run

sudo umount isomount
rm -rf isomount ~/VBoxGuestAdditions.iso
