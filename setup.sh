#!/bin/bash

# ---
# Full Arch Linux Setup Script
# ---

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Starting full Arch Linux setup..."
echo "This script will prompt for your sudo password for system-wide changes."
echo ""

# --- 1. System Update and Package Installation ---
echo "--- [Step 1/9] Updating system and installing Pacman packages ---"
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm --needed \
    git \
    github-cli \
    htop \
    nano \
    vim \
    neovim \
    kitty \
    zsh \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    eza \
    fzf \
    bat \
    tmux \
    discord \
    spotify-launcher \
    gparted \
    grub-customizer \
    bluez \
    blueman \
    bluez-utils \
    ttf-firacode-nerd \
    fastfetch \
    inetutils

echo "Package installation complete."
echo ""

# --- 2. Bluetooth Setup ---
echo "--- [Step 2/9] Setting up Bluetooth ---"
sudo modprobe btusb
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
echo "Bluetooth enabled and started."
echo ""

# --- 3. Clone Dotfiles ---
echo "--- [Step 3/9] Cloning dotfiles repository ---"
# Ensure 'Documents' directory exists
mkdir -p ~/Documents
# Clone into 'dotfiles' directory, handling 'cd' in a subshell
(cd ~/Documents && {
    if [ -d "dotfiles" ]; then
        echo "Dotfiles directory already exists. Pulling latest changes..."
        (cd dotfiles && git pull)
    else
        echo "Cloning dotfiles..."
        git clone https://github.com/Sysfazzz/dotfiles.git
    fi
})
echo "Dotfiles repository is ready."
echo ""

# --- 4. CLI Setup (Zsh, Tmux, Vim, etc.) ---
echo "--- [Step 4/9] Setting up CLI environment ---"

# Create directories for custom zsh plugin paths
mkdir -p ~/.zsh/zsh-syntax-highlighting
mkdir -p ~/.zsh/zsh-autosuggestions

# Symlink the system-installed plugins to the locations your .zshrc expects
echo "Symlinking Zsh plugins..."
ln -sf /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ln -sf /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Create config directory
mkdir -p ~/.config

# Symlink dotfiles from the cloned repo
echo "Symlinking dotfiles..."
ln -sf ~/Documents/dotfiles/.zshrc ~/.zshrc
ln -sf ~/Documents/dotfiles/.zshenv ~/.zshenv
ln -sf ~/Documents/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/Documents/dotfiles/.vimrc ~/.vimrc
ln -sf ~/Documents/dotfiles/kitty ~/.config/kitty
ln -sf ~/Documents/dotfiles/fastfetch ~/.config/fastfetch

echo "Setting Zsh as default shell (will ask for password)..."
# This changes the shell for the *current* user
chsh -s $(which zsh)
echo "CLI setup complete."
echo ""

# --- 5. GUI Setup (Themes & Icons) ---
echo "--- [Step 5/9] Setting up GUI (Themes, Icons, Cursors) ---"
mkdir -p ~/.icons
echo "Installing cursor theme..."
ln -sf ~/Documents/dotfiles/cursors/gruvbox-material-dark ~/.icons/Cursor-Gruvbox-Dark

echo "Setting cursor size..."
gsettings set org.gnome.desktop.interface cursor-size 32

echo "Installing icon theme..."
ln -sf ~/Documents/dotfiles/icons/gruvbox-plus-icon-pack/Gruvbox-Plus-Dark/ ~/.icons/Icon-Gruvbox-Dark

echo "Installing GTK theme..."
THEME_INSTALL_DIR=~/Documents/dotfiles/themes/Gruvbox-GTK-Theme/themes
if [ -f "$THEME_INSTALL_DIR/install.sh" ]; then
    chmod +x "$THEME_INSTALL_DIR/install.sh"
    (cd "$THEME_INSTALL_DIR" && ./install.sh -n Theme-Gruvbox-Dark -t yellow -c dark -l --tweaks medium)
    echo "GTK theme installed."
else
    echo "WARNING: Could not find GTK theme install script at $THEME_INSTALL_DIR/install.sh"
fi
echo "GUI setup complete."
echo ""

# --- 6. YAY Setup (AUR Helper) ---
echo "--- [Step 6/9] Installing 'yay' AUR Helper ---"
# 'cd' into a subshell to not affect script's working directory
(
    # Clone to a temporary directory or home
    cd ~
    if [ -d "yay" ]; then
        echo "'yay' directory already exists. Pulling changes."
        (cd yay && git pull)
    else
        echo "Cloning 'yay'..."
        git clone https://aur.archlinux.org/yay.git
    fi
    cd yay
    echo "Building and installing 'yay' (makepkg -si)..."
    makepkg -si --noconfirm
)
echo "'yay' installation complete."
echo ""

# --- 7. Brave Browser Setup ---
echo "--- [Step 7/9] Installing Brave Browser ---"
echo "Running Brave install script. This will require sudo."
curl -fsS https://dl.brave.com/install.sh | sudo sh
echo "Brave installation complete."
echo ""

# --- 8. Starship Prompt Setup ---
echo "--- [Step 8/9] Installing Starship Prompt ---"
echo "Running Starship install script. This will require sudo."
curl -sS https://starship.rs/install.sh | sudo sh -s -- -y
echo "Applying Starship preset..."
starship preset nerd-font-symbols -o ~/.config/starship.toml
echo "Starship setup complete."
echo ""

# --- 9. Final AUR Installs ---
echo "--- [Step 9/9] Installing AUR packages with 'yay' ---"
# Use 'yay' to install remaining packages
yay -S --noconfirm --needed cava extension-manager preload
echo "AUR packages installed."
echo ""

# --- Finished ---
echo "------------------------------------------------------------------"
echo "✅ All done! Your Arch Linux system is configured."
echo ""
echo "IMPORTANT:"
echo "  - You MUST log out and log back in for all changes to take effect."
echo "  - This includes the new shell (Zsh) and all GUI themes."
echo "------------------------------------------------------------------"
