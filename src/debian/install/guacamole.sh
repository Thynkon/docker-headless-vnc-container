#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

GUACAMOLE_VERSION=1.5.1

# Dependencies
sudo apt-get install -y libcairo2-dev libjpeg62-turbo-dev libpng-dev libtool-bin uuid-dev \
    libavcodec-dev libavformat-dev libavutil-dev libswscale-dev freerdp2-dev libpango1.0-dev libssh2-1-dev libtelnet-dev

pushd /tmp

wget -O "guacamole-server.$GUACAMOLE_VERSION.tar.gz" "https://apache.org/dyn/closer.lua/guacamole/$GUACAMOLE_VERSION/source/guacamole-server-$GUACAMOLE_VERSION.tar.gz?action=download" \
    && tar -xf "guacamole-server.$GUACAMOLE_VERSION.tar.gz"

pushd "guacamole-server-$GUACAMOLE_VERSION"

# Build
autoreconf -fi &&  ./configure --with-init-dir=/etc/init.d && make

# Install and enable
sudo sudo make install && sudo ldconfig && sudo update-rc.d guacd defaults

# Cleanup
popd && rm -rf "guacamole-server-$GUACAMOLE_VERSION" && rm "guacamole-server.$GUACAMOLE_VERSION.tar.gz"