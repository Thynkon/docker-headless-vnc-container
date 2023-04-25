#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

ASDF_VERSION=0.11.3
ERLANG_VERSION=25.3
ELIXIR_VERSION=1.14.4

echo "Install Erlang and Elixir runtime"
sudo apt-get install -y curl git unzip build-essential gcc libncurses5 libsctp1 libncursesw5-dev libssl-dev inotify-tools libwxgtk3.0-gtk3-0v5

pushd /tmp

# Install Erlang
wget https://packages.erlang-solutions.com/erlang/debian/pool/esl-erlang_25.3-1~debian~bullseye_amd64.deb
sudo DEBIAN_FRONTEND=noninteractive dpkg -i esl-erlang_25.3-1~debian~bullseye_amd64.deb
rm esl-erlang_25.3-1~debian~bullseye_amd64.deb

# Install Elixir
wget https://github.com/elixir-lang/elixir/releases/download/v1.14.4/elixir-otp-25.zip
unzip elixir-otp-25.zip -d "elixir-1.14.4-otp-25" && sudo mv "elixir-1.14.4-otp-25" "/opt/elixir-1.14.4-otp-25"

echo "export PATH=/opt/elixir-1.14.4-otp-25/bin:$PATH" >> ~/.bashrc && source ~/.bashrc
rm /tmp/elixir-otp-25.zip && popd

# Install Hex
mix local.hex --force && mix local.rebar --force

# Install Phoenix
mix archive.install hex phx_new --force

sudo apt-get clean -y