#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

sudo apt-get update -y && sudo apt-get install -y codium

# Enable VSCode marketplace

mkdir -p /headless/.config/VSCodium

echo '{
  "extensionsGallery": {
    "serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery",
    "itemUrl": "https://marketplace.visualstudio.com/items",
    "cacheUrl": "https://vscode.blob.core.windows.net/gallery/index",
    "controlUrl": ""
  }
}' > /headless/.config/VSCodium/product.json

# Setup config
mkdir -p /headless/.config/VSCodium/User

echo '{
  "window.zoomLevel": 1,
  "telemetry.telemetryLevel": "off",
  "editor.fontFamily": "FiraCode Nerd Font Mono",
  "terminal.external.linuxExec": "alacritty",
  "terminal.integrated.defaultProfile.linux": "zsh",
  "editor.fontLigatures": true,
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.organizeImports": true
  },
  "security.workspace.trust.untrustedFiles": "open",
  "workbench.colorTheme": "One Monokai",
  "editor.inlineSuggest.enabled": true,
  "[html]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "files.associations": {
    "*.heex": "phoenix-heex"
  }
}' > /headless/.config/VSCodium/User/settings.json

echo "alias codium='codium --no-sandbox'" >> /headless/.bashrc

source /headless/.bashrc
# Install extensions
extensions=("JakeBecker.elixir-ls" "phoenixframework.phoenix" "vscodevim.vim")

for extension in "${extensions[@]}"; do
    codium --install-extension $extension
done

sudo apt-get clean -y