#Font Setup
sudo pacman -S ttf-firacode-nerd

# CLI Setup
ln -s ~/Documents/dotfiles/.zshrc ~/.zshrc
ln -s ~/Documents/dotfiles/.zshenv ~/.zshenv
ln -s ~/Documents/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/Documents/dotfiles/.vimrc ~/.vimrc
ln -s ~/Documents/dotfiles/kitty ~/.config/kitty
ln -s ~/Documents/dotfiles/fastfetch ~/.config/fastfetch

#GUI Setup
ln -s ~/Documents/dotfiles/cursors/gruvbox-material-dark ~/.icons/Cursor-Gruvbox-Dark
gsettings set org.gnome.desktop.interface cursor-size 32
ln -s ~/Documents/dotfiles/icons/gruvbox-plus-icon-pack/Gruvbox-Plus-Dark/ ~/.icons/Icon-Gruvbox-Dark
cd ~/Documents/dotfiles/themes/Gruvbox-GTK-Theme/themes
./install.sh -n Theme-Gruvbox-Dark -t yellow -c dark -l --tweaks medium