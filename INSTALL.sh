#!/bin/bash

# Amber's Dotfiles

#     _____   ________________    __    __           __
#    /  _/ | / / ___/_  __/   |  / /   / /     _____/ /_
#    / //  |/ /\__ \ / / / /| | / /   / /     / ___/ __ \
#  _/ // /|  /___/ // / / ___ |/ /___/ /____ (__  ) / / /
# /___/_/ |_//____//_/ /_/  |_/_____/_____(_)____/_/ /_/

#---------------------------------------------------------------------
# Installation Script
#
# Conduct all necessary steps to install and configure my system
# using my Arch Linux Dotfiles
#
# This script is meant to be ran as sudo in order to use pacman
#---------------------------------------------------------------------

#---------------------------------------------------------------------
# Variables
# Handy bash variables to have around for later
#---------------------------------------------------------------------

# Thanks to colors.sh
NO_FMT="\033[0m"
F_BOLD="\033[1m"
C_AQUA="\033[38;5;14m"
C_LIME="\033[38;5;10m"

USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6) # Thanks to dogbane on stackoverflow

#   ___                              _   _    _            _   _ _   _ _
#  / __|___ _ __  _ __  __ _ _ _  __| | | |  (_)_ _  ___  | | | | |_(_) |___
# | (__/ _ \ '  \| '  \/ _` | ' \/ _` | | |__| | ' \/ -_) | |_| |  _| | (_-<
#  \___\___/_|_|_|_|_|_\__,_|_||_\__,_| |____|_|_||_\___|  \___/ \__|_|_/__/

#---------------------------------------------------------------------
# Install core command line applications
#---------------------------------------------------------------------

echo -e "[${F_BOLD}${C_LIME}Installation${NO_FMT}]: Command line utilities"
sleep 5
pacman -S btop neovim ranger sed stow zsh zsh-autosuggestions zsh-syntax-highlighting
chsh -s $(which zsh)

#  _  _               _              _    ___
# | || |_  _ _ __ _ _| |__ _ _ _  __| |  / __|___ _ _ ___
# | __ | || | '_ \ '_| / _` | ' \/ _` | | (__/ _ \ '_/ -_)
# |_||_|\_, | .__/_| |_\__,_|_||_\__,_|  \___\___/_| \___|
#       |__/|_|

echo -e "[${F_BOLD}${C_LIME}Installation${NO_FMT}]: Hyprland core"
sleep 5
pacman -S hyprland qt5-wayland qt6-wayland xdg-desktop-portal-hyprland

#  ___  ___             __  ___
# |   \| _ )_  _ ___   / / |   \ __ _ ___ _ __  ___ _ _  ___
# | |) | _ \ || (_-<  / /  | |) / _` / -_) '  \/ _ \ ' \(_-<
# |___/|___/\_,_/__/ /_/   |___/\__,_\___|_|_|_\___/_||_/__/
#

echo -e "[${F_BOLD}${C_LIME}Installation${NO_FMT}]: System bus applications & daemons"
sleep 5
pacman -S blueman brightnessctl cliphist network-manager-applet polkit-kde-agent tumbler wl-clipboard
# yay -S wl-clip-persist (doesn't seem to be required?)

#  ___         _   _                __  ___ _        _ _
# |   \ ___ __| |_| |_ ___ _ __    / / / __| |_ _  _| (_)_ _  __ _
# | |) / -_|_-< / /  _/ _ \ '_ \  / /  \__ \  _| || | | | ' \/ _` |
# |___/\___/__/_\_\\__\___/ .__/ /_/   |___/\__|\_, |_|_|_||_\__, |
#                         |_|                   |__/         |___/

echo -e "[${F_BOLD}${C_LIME}Installation${NO_FMT}]: Desktop accessories, utilities, and customization"
sleep 5
pacman -S cutefish-icons grim hypridle hyprlock imagemagick kitty mako plymouth starship swappy ttf-jetbrains-mono-nerd ttf-zed-mono-nerd waybar wofi
runuser -u $SUDO_USER yay -S hyprpicker plymouth-theme-arch-logo pywal-16-colors sddm-theme-corners-git swww wlogout


#    _                    __  __  __ _
#   /_\  _ __ _ __ ___   / / |  \/  (_)___ __
#  / _ \| '_ \ '_ (_-<  / /  | |\/| | (_-</ _|
# /_/ \_\ .__/ .__/__/ /_/   |_|  |_|_/__/\__|
#       |_|  |_|

echo -e "[${F_BOLD}${C_LIME}Installation${NO_FMT}]: Desktop applications and miscellaneous software"
sleep 5
pacman -S cheese file-roller firefox gimp gnome-text-editor inkscape kvantum libreoffice-fresh loupe nwg-look pavucontrol python-pyfiglet qt6ct snapper thunar
runuser -u $SUDO_USER yay -S tidal-hifi-bin snp

#  ___      _    __ _ _            __   ___  __
# |   \ ___| |_ / _(_) |___ ___   / /  / __|/ _|__ _
# | |) / _ \  _|  _| | / -_|_-<  / /  | (__|  _/ _` |
# |___/\___/\__|_| |_|_\___/__/ /_/    \___|_| \__, |
#                                              |___/

#---------------------------------------------------------------------
# Stow dotfiles
#---------------------------------------------------------------------

echo -e "[${F_BOLD}${C_AQUA}Config${NO_FMT}]: Stow dotfiles"
sleep 5
stow --adopt .
git restore

#---------------------------------------------------------------------
# Modify the Corners sddm theme / sddm conf
#---------------------------------------------------------------------

echo -e "[${F_BOLD}${C_AQUA}Config${NO_FMT}]: Modify SDDM configuration & theme"
sleep 5
sh -c "echo -e '[Theme]\nCurrent=corners' > /etc/sddm.conf"
cp -f sddm/scripts/* /usr/share/sddm/scripts/
chmod +x /usr/share/sddm/scripts/*
rm -r /usr/share/sddm/themes/corners/backgrounds
# Didn't seem to want to link without me removing original directory,
# even though I used -f
ln -sf $USER_HOME/.backgrounds /usr/share/sddm/themes/corners/backgrounds
cp -f sddm/themes/corners/theme.conf /usr/share/sddm/themes/corners/theme.conf

#---------------------------------------------------------------------
# Configure and enable Plymouth
#---------------------------------------------------------------------

echo -e "[${F_BOLD}${C_AQUA}Config${NO_FMT}]: Configure and enable Plymouth"
sleep 5

# Append "quiet splash" to the systemd bootloader params
BOOTLOADER_CONFIG=/boot/loader/entries/arch.conf
END_LINE=$(sed -n '$p' $BOOTLOADER_CONFIG)
sed -i '$d' $BOOTLOADER_CONFIG
echo "${END_LINE} quiet splash" >> $BOOTLOADER_CONFIG

# Add plymouth to mkinitcpio hooks - This inserts it after udev in the only
# un-commmented HOOKS line in default mkinitcpio.conf
# Thanks to Nayr438 on the LTT forums
sed -i "/^HOOKS=/ s/autodetect/plymouth &/g" /etc/mkinitcpio.conf

# Append ShowDelay=0 to plymouthd.conf
echo "ShowDelay=0" >> /etc/plymouth/plymouthd.conf

# Set plymouth theme and rebuild mkinitcpio
plymouth-set-default-theme -R arch-logo

#     _______       _      __             ____
#    / ____(_)___  (_)____/ /_  ___  ____/ / /
#   / /_  / / __ \/ / ___/ __ \/ _ \/ __  / /
#  / __/ / / / / / (__  ) / / /  __/ /_/ /_/
# /_/   /_/_/ /_/_/____/_/ /_/\___/\__,_(_)

systemctl reboot
