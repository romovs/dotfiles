# dotfiles

dotfiles and fresh system installation instructions for personal use.

## Dnf
```bash
sudo dnf remove parole thunderbird hexchat transmission-gtk abrt ffmpeg-free mate-calc blivet-gui gnote caja pluma plymou* mate-system-monitor 
```
```bash
sudo dnf copr enable atim/bottom -y
```
```bash
sudo dnf install ffmpeg fuse-libs hplip-gui galculator gcc-c++ gimp wireshark deluge unrar flac mpd mpc ncmpcpp google-droid-sans-fonts google-droid-sans-mono-fonts ffmpegthumbnailer kdiff3 zsh kernel-devel kernel-headers gcc mpv nmap darktable libsane-hpaio nemo nemo-fileroller cmake git powerline-fonts papirus-icon-theme papirus-icon-theme-dark arc-theme VirtualBox libreoffice-calc libreoffice-writer dkms acpid libglvnd-devel vdpauinfo libva-vdpau-driver libva-utils alacritty avidemux ImageMagick flacon libva-intel-driver intel-media-driver gstreamer1-vaapi fuse polybar rofi i3
```

Install: `https://github.com/Toqozz/wired-notify`

If no EAC3 codec support then remove `ffmpeg-free` from Fedora repos and isntall `ffmpeg` from RPMFusion.


## i3 over mate
```bash
gsettings set org.mate.session.required-components windowmanager 'i3'
gsettings set org.mate.session required-components-list "['windowmanager']"
gsettings set org.mate.session.required-components panel ''
gsettings set org.mate.background show-desktop-icons false
gsettings set org.mate.peripherals-keyboard-xkb.general disable-indicator true
```

## Firefox extensions
https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/           (see external file for custom filters)  
https://addons.mozilla.org/en-US/firefox/addon/youtube_downloader_webx/

## Sublime
- Theme: Adaptive
- Color Scheme: Catppuccin
- A File Icon
- TrailingSpaces 
- ColorHelper
- BracketHighlighter
- SideBarEnhancements
- RON

Sublime settings
```json
{
       "ignored_packages":
       [
              "Vintage",
       ],
       "color_scheme": "Catppuccin Mocha.sublime-color-scheme",
       "theme": "Adaptive.sublime-theme",
       "font_size": 9,
       "index_files": true,
       "show_encoding" : true,
}
```

## Zsh
https://github.com/robbyrussell/oh-my-zsh
```bash
sudo chsh -s /bin/zsh root
sudo ln -s $HOME/.oh-my-zsh /root/.oh-my-zsh
sudo ln -s $HOME/.zshrc /root/.zshrc
```

## Theme
Theme - Retro  
Font  - Droid Sans Regular 10  
Icons - Papirus Dark (papirus-icon-theme-dark)  

## Icons for Rofi
https://github.com/bikass/kora 
Place in $HOME/.icons/kora

## Tools
```bash
sudo ln -s /opt/android-studio/bin/studio.sh /usr/local/bin/android
sudo ln -s /opt/idea-IC-211.7142.45/bin/idea.sh /usr/local/bin/idea
sudo ln -s /opt/Morgen/morgen /usr/local/bin/morgen
sudo ln -s /opt/Telegram/Telegram /usr/local/bin/telegram
sudo ln -s ~/projects/wired-notify/target/release/wired /usr/sbin/wired
sudo ln -s /var/lib/snapd/snap/bin/skype /usr/sbin/skype
```

## Customization
Copy icon into clipboard `echo -ne "\ue897" | xclip -selection clipboard`  
Reload X resources `xrdb ~/.Xresources`

## Thinkpad
Throttle fix https://github.com/erpalma/lenovo-throttling-fix  
Custom boot logo https://www.reddit.com/r/thinkpad/comments/a57xhc/guide_custom_boot_logo_on_a_t480/  
WoL permanent disable (https://wiki.archlinux.org/index.php/Wake-on-LAN)  
```
$ vi /etc/udev/rules.d/81-wol.rules

ACTION=="add", SUBSYSTEM=="net", NAME=="enp*", RUN+="/usr/sbin/ethtool -s $name wol d"

$ udevadm control --reload
```

Disble NMI Watchdog:
```
sudo vi /etc/default/grub

GRUB_CMDLINE_LINUX="rhgb quiet nmi_watchdog=0"

sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

Issue with keyboard backlight on Mate.
https://github.com/mate-desktop/mate-desktop/issues/306
https://wiki.archlinux.org/title/Keyboard_backlight

```
$ vi /usr/share/dbus-1/system.d/org.freedesktop.UPower.conf

<?xml version="1.0" encoding="UTF-8"?> <!-- -*- XML -*- -->

<!DOCTYPE busconfig PUBLIC
 "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>
  <!-- Only root can own the service -->
  <policy user="root">
    <allow own="org.freedesktop.UPower"/>
  </policy>
  <policy context="default">

    <allow send_destination="org.freedesktop.UPower"
           send_interface="org.freedesktop.DBus.Introspectable"/>

    <allow send_destination="org.freedesktop.UPower"
           send_interface="org.freedesktop.DBus.Peer"/>
    <allow send_destination="org.freedesktop.UPower"
           send_interface="org.freedesktop.DBus.Properties"/>
    <allow send_destination="org.freedesktop.UPower.Device"
           send_interface="org.freedesktop.DBus.Properties"/>
    <deny send_destination="org.freedesktop.UPower.KbdBacklight"
           send_interface="org.freedesktop.DBus.Properties"/>
    <allow send_destination="org.freedesktop.UPower.Wakeups"
           send_interface="org.freedesktop.DBus.Properties"/>

    <allow send_destination="org.freedesktop.UPower"
           send_interface="org.freedesktop.UPower"/>
    <allow send_destination="org.freedesktop.UPower"
           send_interface="org.freedesktop.UPower.Device"/>
    <deny send_destination="org.freedesktop.UPower"
           send_interface="org.freedesktop.UPower.KbdBacklight"/>
    <allow send_destination="org.freedesktop.UPower"
           send_interface="org.freedesktop.UPower.Wakeups"/>
  </policy>
</busconfig>

```


## Nemo
Disable recent files: 
```bash
gsettings set org.cinnamon.desktop.privacy remember-recent-files false
```
```bash
sudo rm -f /usr/share/nemo/actions/send-by-mail.nemo_action

```
