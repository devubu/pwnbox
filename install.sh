#!/bin/zsh

# Update and upgrade
sudo apt update -y
sudo apt full-upgrade -y

# Install packages
sudo apt install -y xclip
sudo apt install -y ripgrep
sudo apt install -y fzf
sudo apt install -y bat
sudo apt install -y nodejs
sudo apt install -y npm
sudo apt install -y python3.11-venv
sudo apt install -y rlwrap

# Install packages required for Alacritty
sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

# Install Tmux configuration
git clone https://github.com/devubu/tmux.git ~/.config/tmux
git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

# Install Alacritty configuration
git clone https://github.com/devubu/alacritty.git ~/.config/alacritty

# Download and install FiraCode Nerd Font
curl -o ~/Downloads/FiraCode.zip -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip
unzip -q ~/Downloads/FiraCode.zip -d ~/Downloads/FiraCode -x "LICENSE" "readme.md" && rm ~/Downloads/FiraCode.zip
sudo chown -R root:root ~/Downloads/FiraCode
sudo mv ~/Downloads/FiraCode /usr/share/fonts/truetype
fc-cache -f -v

# Remove pre-existing Neovim config
rm -rf ~/.config/nvim

# Download and install Neovim
curl -o ~/Downloads/nvim.appimage -L https://github.com/neovim/neovim/releases/download/v0.10.0/nvim.appimage
sudo chown root:root ~/Downloads/nvim.appimage
sudo chmod +x ~/Downloads/nvim.appimage
sudo mv ~/Downloads/nvim.appimage /usr/bin/nvim

# Download .zshrc
curl -o ~/.zshrc -L https://raw.githubusercontent.com/devubu/zshrc/main/.zshrc

# Source the .zshrc
source ~/.zshrc

# Download Neovim configuration
git clone https://github.com/devubu/nvim.git ~/.config/nvim

# Start Neovim headless to initialize plugins
nvim --headless "+q"

# Download Alacritty
git clone https://github.com/alacritty/alacritty.git ~/alacritty

# Install Alacritty
cargo build --release --manifest-path ~/alacritty/Cargo.toml

# Verify alacritty terminfo is already installed
infocmp alacritty

# Install desktop entry for Alacritty
sudo cp ~/alacritty/target/release/alacritty /usr/local/bin
sudo cp ~/alacritty/extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install ~/alacritty/extra/linux/Alacritty.desktop
sudo update-desktop-database

# Download Opacity script
git clone https://github.com/devubu/opacity.git ~/Tools/Custom/Bash/config_editor/alacritty/opacity

# Install Opacity script
source ~/Tools/Custom/Bash/config_editor/alacritty/opacity/install.sh

# Downlaod Info scripts
git clone https://github.com/devubu/info.git ~/Tools/Custom/Bash/info

# Install Info scripts
source ~/Tools/Custom/Bash/info/install.sh

# Download Rustscan
git clone https://github.com/RustScan/RustScan.git ~/rustscan

# Install Rustscan
cargo build --release --manifest-path ~/rustscan/Cargo.toml
sudo cp ~/rustscan/target/release/rustscan /usr/local/bin

# Remove Alacritty Directory
rm -rf ~/alacritty

# Remove Rustscan Directory 
rm -rf ~/rustscan

# Check if ~/.bashrc contains a line with only the word 'zsh'
if ! grep -qx "zsh" ~/.bashrc; then
    # Add 'zsh' to the end of ~/.bashrc if not already present
    echo "zsh" >> ~/.bashrc
    # echo "Added 'zsh' to ~/.bashrc"
# else
    # echo "'zsh' is already present in ~/.bashrc"
fi

