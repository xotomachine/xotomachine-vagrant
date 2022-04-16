#!/bin/sh

# Update the system
export DEBIAN_FRONTEND=noninteractive
apt-mark hold keyboard-configuration
apt-get update
apt-mark unhold keyboard-configuration

###########################################
# Install the graphical environment
###########################################



# Force encoding
echo 'LANG=en_US.UTF-8' >> /etc/environment
echo 'LANGUAGE=en_US.UTF-8' >> /etc/environment
echo 'LC_ALL=en_US.UTF-8' >> /etc/environment
echo 'LC_CTYPE=en_US.UTF-8' >> /etc/environment


# # Versions
# echo 'NVM_VERSION=0.33.2' >> /etc/environment
# echo 'YARN_VERSION=1.8.0' >> /etc/environment
# echo 'POSTGRES_VERSION=12' >> /etc/environment
# echo 'JAVA_VERSION=11' >> /etc/environment
# echo 'RUBBY_VERSION=2.1.1' >> /etc/environment
# echo 'NERDS_FONT_VERSION=2.1.0' >> /etc/environment
# echo 'FZF_VERSION=0.21.1' >> /etc/environment
# echo 'GITSTATUS_VERSION=1.0.0' >> /etc/environment
# echo 'REPO_PATH=../ubuntu-machine-docker/setup/ubuntu/' >> /etc/environment

# Run GUI as non-privileged user
echo 'allowed_users=anybody' > /etc/X11/Xwrapper.config

# Install Ubuntu desktop and VirtualBox guest tools
apt-get install -y ubuntu-desktop virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

apt-get remove -y light-locker --purge

# Clean the box
apt-get -y autoclean
apt-get -y clean
apt-get -y autoremove
dd if=/dev/zero of=/EMPTY bs=1M > /dev/null 2>&1
rm -f /EMPTY