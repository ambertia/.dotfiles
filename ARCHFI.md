# Archfi configurations, settings choices, and applications

### Main menu
- Keyboard Layout - us
- Editor - vim
- Disk Partitions - Auto Partitions (gpt,efi)

### Format and Mount
- Format Devices - fat32, swap, btrfs

### Install Menu
- Parallel Downloads - 5
- ##### Install Linux
    - Kernel - linux
    - File Systems - dosfstools, btrfs-progs

### Config Arch Linux
- Generate fstab - UUID
- Generate mkinitcpio.conf-nvme
- Bootloader - systemd-boot - Install systemd-boot
- Extras - All
- Archdi - Install and run archdi

### Updates
- Upgrade
- Install yay

### Install
- ##### Console
    - Generic - Add neofetch(deprecated - remove?), base-devel, powertop
    - Compression Tools - All
    - Network Tools - Defaults
- ##### System
    - Services - Add ntp,accept Yes/No defaults
    - File System - Add snapper
    - Sound - wireplumber - Defaults
    - Print - Defaults, Yes
    - Display Manager - sddm, noto-fonts, Yes
- ##### Config
    - ###### Accounts
        - Users - Add User
        - Sudoers - Add sudoer - my account
