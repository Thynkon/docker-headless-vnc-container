#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

GUACAMOLE_VERSION=1.4.0

# Install dependencies

# Dependencies
sudo apt-get install -y build-essential libcairo2-dev libjpeg62-turbo-dev libpng-dev libtool-bin uuid-dev \
    libavcodec-dev libavformat-dev libavutil-dev libswscale-dev freerdp2-dev libpango1.0-dev libssh2-1-dev libtelnet-dev \
    libvncserver-dev libwebsockets-dev libvorbis-dev libpulse-dev libwebp-dev

pushd /tmp

wget -O "guacamole-client.$GUACAMOLE_VERSION.tar.gz" "https://archive.apache.org/dist/guacamole/$GUACAMOLE_VERSION/source/guacamole-server-$GUACAMOLE_VERSION.tar.gz" &&
    tar -xf "guacamole-client.$GUACAMOLE_VERSION.tar.gz"

#wget -O "guacamole-server.$GUACAMOLE_VERSION.tar.gz" "https://apache.org/dyn/closer.lua/guacamole/$GUACAMOLE_VERSION/source/guacamole-server-$GUACAMOLE_VERSION.tar.gz" &&
#    tar -xf "guacamole-server.$GUACAMOLE_VERSION.tar.gz"

pushd "guacamole-server-$GUACAMOLE_VERSION"

# Build
autoreconf -fi && ./configure --with-init-dir=/etc/init.d && make

# Install and enable
sudo sudo make install && sudo ldconfig && sudo update-rc.d guacd defaults

# Cleanup
popd && rm -rf "guacamole-server-$GUACAMOLE_VERSION" && rm "guacamole-server.$GUACAMOLE_VERSION.tar.gz"
