#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

ASDF_VERSION=0.11.3
ERLANG_VERSION=25.3
ELIXIR_VERSION=1.14.4

echo "Install Erlang and Elixir runtime"
sudo apt-get install -y --no-install-recommends curl git unzip build-essential gcc libncurses5 libsctp1 libncursesw5-dev libssl-dev inotify-tools libwxgtk-webview3.0-gtk3-dev libncurses5-dev unixodbc-dev

export KERL_CONFIGURE_OPTIONS="--without-javac --without-jinterface"

# Install ASDF
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch "v$ASDF_VERSION"
echo '. $HOME/.asdf/asdf.sh' >>~/.bashrc
echo '. $HOME/.asdf/completions/asdf.bash' >>~/.bashrc

# Load ASDF
. $HOME/.asdf/asdf.sh

export ASDF_CONCURRENCY=$(nproc)

# Install Erlang
asdf plugin-add erlang
asdf install erlang $ERLANG_VERSION
asdf global erlang $ERLANG_VERSION

# Install Elixir
asdf plugin-add elixir
asdf install elixir $ELIXIR_VERSION
asdf global elixir $ELIXIR_VERSION

# Install Hex
mix local.hex --force && mix local.rebar --force

# Install Phoenix
mix archive.install hex phx_new --force

sudo apt-get clean -y
