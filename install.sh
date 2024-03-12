#!/bin/bash

pre_install() {
    pacman -S git --needed base-devel --noconfirm || exit
}

post_install() {
    git clone https://aur.archlinux.org/yay.git || exit
    cd yay || exit
    makepkg -si --noconfirm || exit
    yay -S neofetch skippy-xd cava ranger mpv rofi wezterm zsh feh xorg-xrandr neovim flameshot notify-osd discord chromium xclip pavucontrol ttf-roboto-mono-nerd nautilus fzf networkmanager exa bat github-cli zsh-autosuggestions zsh-syntax-highlighting meson ninja uthash libconfig --noconfirm || exit
    cd .. && rm -rf yay || exit

    git clone https://github.com/fdev31/picom || exit
    cd picom || exit
    meson setup --buildtype=release . build || exit
    ninja -C build || exit
    sudo cp build/src/picom /usr/bin/picom || exit
    cd .. && rm -rf picom || exit
}

configure_dots() {
    git clone https://github.com/carrotshniper21/dotfiles || exit
    cd dotfiles || exit

    chsh $USER -s /bin/zsh
    rm $HOME/.bash*

    echo "Configuring backgrounds..."
    cp -r backgrounds $HOME/.backgrounds

    echo "Installing lunarvim..."
    bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)

    echo "Copying configuration files..."
    cp -r config/* $HOME/.config || exit

    echo "Copying desktop configuration files..."
    cp desktop/xsession $HOME/.xsession
    sudo cp desktop/dwm.desktop /usr/share/xsessions || exit

    echo "Building dwm and dwmblocks..."
    sudo make clean install -C desktop/dwm || exit
    sudo make clean install -C desktop/dwmblocks || exit

    echo "Moving dwmblocks binaries to /usr/bin..."
    sudo cp bin/* /usr/bin || exit

    echo "Configuring terminal..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    rm $HOME/.zshrc.pre-oh-my-zsh $HOME/.zshrc
    cp shell/* $HOME/ || exit
    echo "DONE!"
}

case "$1" in
    --pre) pre_install ;;
    --post) post_install ;;
    --dots) configure_dots ;;
esac

