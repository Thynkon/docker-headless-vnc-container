#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install some common tools for further installation"
apt-get install -y build-essential vim wget net-tools locales bzip2 procps \
    python3-numpy #used for websockify/novnc
apt-get clean -y

echo "generate locales for en_US.UTF-8"

# Install locales package
apt-get install -y locales

# Uncomment en_US.UTF-8 for inclusion in generation
sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen
locale-gen

# Export env vars
echo "export LC_ALL=en_US.UTF-8" >> ~/.bashrc
echo "export LANG=en_US.UTF-8" >> ~/.bashrc
echo "export LANGUAGE=en_US.UTF-8" >> ~/.bashrc