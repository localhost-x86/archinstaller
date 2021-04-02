#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Turkey /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=trq" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | chpasswd

pacman -S --noconfirm grub networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers alsa-utils pulseaudio rsync

# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

grub-install --target=i386-pc /dev/sdX # replace sdx with your disk name
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

useradd -m user
echo user:password | chpasswd

echo "user ALL=(ALL) ALL" >> /etc/sudoers.d/user


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
