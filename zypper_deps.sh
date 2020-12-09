#!/bin/bash

sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub
sudo zypper ar https://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper ar https://packages.microsoft.com/yumrepos/vscode vscode

sudo rpm --import http://ftp.gwdg.de/pub/linux/misc/packman/public-keys.asc
sudo zypper ar http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_15.2/ Packman

sudo zypper ar https://download.opensuse.org/repositories/graphics/openSUSE_Leap_15.2/ graphics

sudo zypper refresh
sudo zypper in \
    htop \
    imagewriter \
    git \
    emacs-nox \
    tmux \
    blender \
    gimp \
    inkscape \
    code \
    google-chrome-stable \
    keepassxc \
    noto-coloremoji-fonts \
    docker \
    python3-docker-compose \
    python3-devel \
    vlc \
    vlc-codecs \
    exfat-utils \
	jq sqlite3 curl bind-utils

# udev rules
sudo cp ./dev/dotfiles/udev/*.rules /etc/udev/rules.d
sudo cp ./dev/dotfiles/udev/*.sh /usr/local/bin
