#!/bin/bash

sudo bash -c 'cat << EOF > /etc/modprobe.d/nvidia.conf
options nvidia_drm modeset=1
EOF'

sudo bash -c 'cat <<EOF > /etc/dracut.conf.d/nvidia.conf
add_drivers+="nvidia nvidia_modeset nvidia_uvm nvidia_drm"
install_items+="/etc/modprobe.d/nvidia.conf"
EOF'

sudo zypper ar https://download.nvidia.com/opensuse/leap/15.2 NVIDIA
sudo zypper in x11-video-nvidiaG05

sudo dracut -f
