## Dotfile Notes

- Themeing applications gets a bit complicated
    - GTK applications can be themed with lxappearance, but nwg-look seems to work better
    - KDE applications use qt6, qt applications can be themed with qt6ct
    - Would be wise to keep both on hand
    - KDE applications also can support kvantum themes, installed with kvantum
    - libadwaita-without-adwaita-git from the AUR makes libadwaita applications respect the system GTK theme

- Decide if I want mostly GTK applications or KDE applications
    - Get GTK apps

###### Misc packages
power-profiles-daemon for power profile management, integrates with Waybar

###### Required applications
- Look into the gnome suite - everything I can install without installing gnome itself

#### Useful applications
- hyprpicker Terminal color picker for Hyprland

###### Clipboard history
- cliphist
- wl-clip-persist enables clipboard history to be preserved after source application is closed
- wl-clipboard dependency
- wtype allows for automatic virtual keypresses if so desired

###### File browser
- Thunar
- Needs tumbler installed for image previews

###### Waybar modules I'm interested in for basic theme
- Left: Window title, application cycling thingy?
- Center: Workspaces
- Right: Volume, CPU, Temp, MEM, Brightness, Battery, date/time, tray (figure out how to style network & bluetooth? custom waybar modules? maybe check that guy's dotfiles)

###### Audio
- pipewire audio backend
- wireplumber audio server
- pipewire-pulse to connect pipewire to pulseaudio applications
- pavucontrol for GUI audio control

###### Clock
- ntp package has network time sync service. I would think this would get installed by default? whatever.

## Styling for starter style
- Green-ish color for now 5BCE22
- Maroon for "off" or "bad" CC2014
- Yellow / goldenrod for "warning" FFD700 (Gold in CSS colors)
- Use a proportional nerd font to center icons correctly e.g. ZedMono NFP

▁▂▃▄▅▆▇█

## INSTALL SCRIPT ORDER OF OPERATIONS
- Install command line utilities
- Install and build yay
- Install hyprland core
- Install system bus applications & daemons (check what's installed already?)
- Install desktop accessories & customization
- Install other misc applications
- Stow dotfiles
- Modify sddm files - symlink background images folder to .backgrounds?
- Append bootloader conf - add "quiet splash"
- Modify / overwrite mkinitcpio
- Append ShowDelay=0 to /etc/plymouth/plymouthd.conf
- Set Plymouth theme - will rebuild initramfs

## APPS

#### Command line utilities
- git (No, need this to clone repo! will have to be installed manually)
- base-devel
- bash-completion
- btop
- neovim
- zsh
- stow
- sed

- yay (clone from aur)s

#### Base hyprland
- hyprland
- xdg-desktop-portal-hyprland
- qt5-wayland
- qt6-wayland


#### System bus & daemons
- pipewire
- pipewire-pulse
- wireplumber
- blueman for bluetooth
- brightnessctl
- cliphist
- wl-clipboard
- wl-clip-persist (aur)
- polkit-gnome
- networkmanager
- network-manager-applet
- tumbler

#### Desktop accessories & prettying
- plymouth
- plymouth-theme-dark-arch (aur)
- waybar
- wlogout (aur)
- sddm
- sddm-theme-corners-git (aur)
- swww
- wofi
- mako
- grim
- swappy
- ttf-jetbrains-mono-nerd
- ttf-zed-mono-nerd
- hyprpicker (aur)
- hypridle
- hyprlock
- ntp
- pywal-16-colors (aur)
- imagemagick
- starship

#### GTK utilities / desktop apps
- fileroller
- pavucontrol
- thunar
- thunar-archive-plugin (?)
- nwg-look
- qt6ct
- kvantum
- cutefish-icons
- gnome-text-editor
- cheese

#### Media and extras
- tidal-hifi-bin (aur)
- python-pyfiglet
- inkscape
- libreoffice-fresh
- loupe

- snapper
- snp (aur)
