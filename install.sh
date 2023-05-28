#!/bin/bash

move_files () {
    echo "[*] Moving dotfiles"

    cp zshrc ~/.zshrc
    cp picom.conf "$XDG_CONFIG_HOME/picom.conf"
    cp -r nvim "$XDG_CONFIG_HOME/nvim"
    cp -r neofetch "$XDG_CONFIG_HOME/neofetch"
    cp -r mpv "$XDG_CONFIG_HOME/mpv"
    cp -r kitty "$XDG_CONFIG_HOME/kitty"
    cp -r rofi "$XDG_CONFIG_HOME/kitty"
}

install_dwm () {
    echo "[*] Installing dwm"
    sudo make clean install -C ~/dotfiles/dwm
}

install_dwmblocks () {
    echo "[*] Installing dwmblocks"
    sudo make clean install -C ~/dotfiles/dwmblocks
}

check_dependencies () {
    echo -n "Checking dependencies... "

    for name in fzf rofi kitty flameshot ranger nvim; do
        [[ $(which $name 2>/dev/null) ]] || {
            echo -en "\n$name needs to be installed."
            echo -n " Do you want to install it? (Y/n): "
            read -r response
            if [[ $response =~ ^[Yy]$ ]]; then
                sudo apt-get install "$name"
            else
                deps=1
            fi
        }
    done

    [[ $deps -ne 1 ]] && {
        echo "OK"
        move_files
        install_dwm
        install_dwmblocks
    } || {
        echo -en "\nInstall the above and rerun this script\n"
        exit 1
    }
}

check_dependencies

