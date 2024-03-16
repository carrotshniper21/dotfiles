#!/bin/bash

pre_install() {
    pacman -S git --needed base-devel --noconfirm || exit
}

post_install() {
    git clone https://aur.archlinux.org/yay.git || exit
    cd yay || exit
    makepkg -si --noconfirm || exit
    cd .. && rm -rf yay || exit
    yay -S neofetch skippy-xd cava ranger mpv rofi wezterm zsh feh xorg-xrandr neovim flameshot notify-osd discord chromium xclip pavucontrol ttf-roboto-mono-nerd thunar lxappearance fzf networkmanager exa bat github-cli zsh-autosuggestions zsh-syntax-highlighting meson ninja uthash libconfig nodejs npm python-pip libsixel imagemagick  --noconfirm || exit

    if [ -e /etc/systemd/system/display-manager.service ]; then 
        default_target=$(basename $(readlink -f /etc/systemd/system/display-manager.service))
        login_manager=${default_target%-*}
        sudo systemctl disable $login_manager || exit
        yay -S sddm --noconfirm || exit
        sudo systemctl enable sddm.service || exit
    else
      yay -S sddm --noconfirm || exit
      sudo systemctl enable sddm.service || exit
    fi

    yay -S qt5‑graphicaleffects qt5‑quickcontrols2 qt5‑svg || exit

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

    echo "(1/8) Configuring backgrounds..."
    cp -r backgrounds $HOME/.backgrounds

    echo "(2/8) Installing lunarvim..."
    bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
    sudo cp .local/bin/lvim /usr/bin/lvim || exit

    echo "(3/8) Copying configuration files..."
    cp -r config/* $HOME/.config || exit

    echo "(4/8) Installing GTK-3 theme..."
    git clone https://github.com/jmattheis/gruvbox-dark-gtk ~/.themes/gruvbox-dark-gtk || exit

    echo "(5/8) Copying desktop configuration files..."
    cp desktop/xsession $HOME/.xsession
    sudo cp desktop/dwm.desktop /usr/share/xsessions || exit
    sudo cp -r desktop/tartarus -r /usr/share/grub/themes || exit
    sudo cp desktop/grub /etc/default/grub || exit
    sudo grub-mkconfig -o /boot/grub/grub.cfg || exit
    sudo cp -r desktop/sugar-candy /usr/share/sddm/themes || exit
    sudo cp desktop/default.conf /usr/lib/sddm/sddm.conf.d/default.conf || exit

    echo "(6/8) Building dwm and dwmblocks..."
    sudo make clean install -C desktop/dwm || exit
    sudo make clean install -C desktop/dwmblocks || exit

    echo "(7/8) Moving dwmblocks binaries to /usr/bin..."
    sudo cp bin/* /usr/bin || exit

    echo "(8/8) Configuring terminal..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    rm $HOME/.zshrc
    cp shell/zshrc $HOME/.zshrc || exit
    echo "DONE!"
}

case "$1" in
    --pre) pre_install ;;
    --post) post_install ;;
    --dots) configure_dots ;;
esac

