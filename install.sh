#!/bin/bash

case "$1" in
  --pre)
      pacman -S git --needed base-devel --noconfirm
      ;;
  --post)
      git clone https://aur.archlinux.org/yay.git || exit
      cd yay || exit
      makepkg -si --noconfirm || exit
      yay -S skippy-xd cava ranger mpv rofi wezterm zsh feh xorg-xrandr neovim flameshot notify-osd discord chromium xclip pavucontrol ttf-roboto-mono-nerd nautilus fzf networkmanager exa bat gh zsh-autosuggestions zsh-syntax-highlighting meson ninja uthash libconfig --noconfirm
      cd .. && rm -rf yay 
      git clone https://github.com/fdev31/picom || exit
      cd picom || exit
      meson setup --buildtype=release . build || exit
      ninja -C build || exit
      sudo cp build/src/picom /usr/bin/picom || exit
      cd .. && rm -rf picom
      ;;
  --dots)
      git clone https://github.com/carrotshniper21/dotfiles
      cd dotfiles || exit
      chsh $USER -s /bin/zsh
      rm $HOME/.bash*
      ;;
esac
