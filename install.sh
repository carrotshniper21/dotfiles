#!/bin/bash

case "$1" in
  --pre)
      pacman -S git --needed base-devel --noconfirm
      ;;
  --post)
      git clone https://aur.archlinux.org/yay.git || exit
      cd yay || exit
      makepkg -si --noconfirm || exit
      yay -S neofetch skippy-xd cava ranger mpv rofi wezterm zsh feh xorg-xrandr neovim flameshot notify-osd discord chromium xclip pavucontrol ttf-roboto-mono-nerd nautilus fzf networkmanager exa bat github-cli zsh-autosuggestions zsh-syntax-highlighting meson ninja uthash libconfig --noconfirm
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
      echo "Copying backgrounds..."
      cp -r backgrounds $HOME/.backgrounds
      echo "Copying dwmblocks binaries..."
      sudo cp bin/* /usr/bin || exit 
      echo "Copying configuration files..."
      cp config/picom.conf $HOME/.config/picom.conf
      cp config/xsession $HOME/.xsession
      echo "Copying desktop configuration..."
      sudo cp desktop/dwm.desktop /usr/share/xsessions || exit
      cp -r desktop/skippy-xd $HOME/.config
      echo "Building (dwm, dwmblocks)"
      sudo make clean install -C desktop/dwm || exit
      sudo make clean install -C desktop/dwmblocks || exit
      echo "Media configuration (mpv, cava)"
      cp -r media/mpv $HOME/.config
      cp -r media/music/cava $HOME/.config
      echo "Configuring launchers (rofi)"
      cp -r desktop/rofi $HOME/.config
      echo "Configuring terminal"
      cp -r terminal/neofetch $HOME/.config
      cp -r terminal/ranger $HOME/.config
      cp -r terminal/wezterm $HOME/.config
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
      rm $HOME/.zshrc.pre-oh-my-zsh $HOME/.zshrc
      cp terminal/zshrc $HOME/.zshrc
      ;;
esac
