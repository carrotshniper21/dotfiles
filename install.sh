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
      git clone https://github.com/carrotshniper21/dotfiles || exit
      cd dotfiles || exit
      
      chsh $USER -s /bin/zsh
      rm $HOME/.bash*
      
      echo "(1/6) Configuring backgrounds"
      cp -r backgrounds $HOME/.backgrounds
      
      echo "(2/6) Copying configuration files (picom, mpv, cava, neofetch, ranger, wezterm, rofi, skippy-xd)"
      cp config/picom.conf $HOME/.config
      cp -r config/mpv $HOME/.config
      cp -r config/cava $HOME/.config
      cp -r config/neofetch $HOME/.config
      cp -r config/ranger $HOME/.config
      cp -r config/wezterm $HOME/.config
      cp -r config/rofi $HOME/.config
      cp -r config/skippy-xd $HOME/.config

      echo "(3/6) Copying desktop configuration files"
      cp desktop/xsession $HOME/.xsession
      sudo cp desktop/dwm.desktop /usr/share/xsessions || exit
      
      echo "(4/6) Building (dwm, dwmblocks)"
      sudo make clean install -C desktop/dwm || exit
      sudo make clean install -C desktop/dwmblocks || exit

      echo "(5/6) Moving dwmblocks binaries to /usr/bin"
      sudo cp bin/* /usr/bin || exit 
      
      echo "(6/6) Configuring terminal (fzf, zsh)"
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
      rm $HOME/.zshrc.pre-oh-my-zsh $HOME/.zshrc
      cp terminal/fzf.zsh $HOME/.fzf.zsh
      cp terminal/zshrc $HOME/.zshrc
      echo "DONE!"
      ;;
esac

