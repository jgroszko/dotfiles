#!/bin/bash

# TODO: Test this
sudo mkdir -p /var/lib/docker
sudo fallocate -l 10G /mnt/docker-volume.img
sudo mkfs.ext4 /mnt/docker-volume.img
sudo sh -c 'echo "/mnt/docker-volume.img /var/lib/docker ext4 defaults 0 0" >> /etc/fstab'
sudo mount /var/lib/docker

# udev rules
sudo cp ./dev/dotfiles/udev/*.rules /etc/udev/rules.d
sudo cp ./dev/dotfiles/udev/*.sh /usr/local/bin

# Extra Package Repos
sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub
sudo zypper ar https://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper ar https://packages.microsoft.com/yumrepos/vscode vscode

sudo rpm --import https://ftp.gwdg.de/pub/linux/misc/packman/public-keys.asc
sudo zypper ar https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_15.5/ Packman

sudo zypper ar https://download.opensuse.org/repositories/graphics/15.5/ graphics

sudo zypper ar https://download.opensuse.org/repositories/home:/Subsurface-Divelog/15.5/ Subsurface

sudo zypper refresh
sudo zypper in \
     htop \
     imagewriter \
     git \
     emacs-nox \
     tmux \
     gimp \
     inkscape \
     code \
     google-chrome-stable \
     keepassxc \
     noto-coloremoji-fonts \
     docker \
     python3-docker-compose \
     python3-devel \
     vlc ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec-full vlc-codecs \
     exfatprogs \
	 glibc-32bit libstdc++6-32bit \
	 subsurface \
	 jq sqlite3 curl bind-utils libpq5 \
	 pipewire-pulseaudio pipewire-tools

# User Groups
sudo usermod -a -G dialout,docker $USER
