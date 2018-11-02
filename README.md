# dotfiles

dotfiles and fresh system installation instructions for personal use.

- i3-gaps (over mate)
- polybar
- termite
- ncmpcpp (urxvt)
- nemo

## dnf
```
dnf install galculator ghex gcc-c++ gimp wireshark deluge unrar flac mpd mpc ncmpcpp google-droid-sans-fonts google-droid-sans-mono-fonts ffmpegthumbnailer kdiff3 zsh kernel-devel kernel-headers gcc mplayer aircrack-ng nmap darktable libsane-hpaio nemo cmake git xorg-x11-fonts-misc ImageMagick
python3-cairo-devel cairo-gobject-devel gobject-introspection-devel dbus-glib-devel python3-devel xcb-proto xcb-util-devel xcb-util-wm-devel xcb-util-image-devel
```

## i3 over mate
### dconf-editor:
org.mate.desktop.session.required-components windowmanager 'i3'
org.mate.desktop.background show-desktop-icons false
org.mate.desktop.session required-components-list ['windowmanager']
org.mate.desktop.session.required-components panel ''
org.mate.peripherals.keyboard.general disable-indicator true

Remove volume icon from tray: Startup Applicaions > Show Desktop Voulme control > false

## Firefox extensions
https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/           (see external file for custom filters)
https://addons.mozilla.org/en-US/firefox/addon/youtube_downloader_webx/


## Sublime
- Theme: Agila Theme (select Agila Neon.sublime-theme)
- Color Scheme: Monokai Black https://github.com/matkl/Monokai-Black
- A File Icon
- Trailling Spaces
- Color Highlight

Settings
```json
{
    "color_scheme": "Packages/Monokai-Black/Monokai Black.tmTheme",
    "dictionary": "Packages/Language - English/en_GB.dic",
    "font_size": 11,
    "highlight_modified_tabs": true,
    "ignored_packages":
    [
    ],
    "open_files_in_new_window": false,
    "overlay_scroll_bars": "enabled",
    "rulers":
    [
        80,
        100
    ],
    "theme": "Agila Neon.sublime-theme",
    "translate_tabs_to_spaces": true
}
```

Keymap
```
[
    {"keys": ["ctrl+m"], "command": "toggle_menu"}
]
```

## zsh
https://github.com/robbyrussell/oh-my-zsh

## Tools
```bash
ln -s /opt/android-studio/bin/studio.sh /usr/local/bin/android
ln -s /opt/smartgit/bin/smartgit.sh /usr/local/bin/smartgit
ln -s /opt/idea-IC-182.4892.20/bin/idea.sh /usr/local/bin/idea
```

## Customization
```
xrdb ~/.Xresources
```

## SmartGit
smartgit - conflict resolver: kdiff3
arguemnts ${baseFile} ${leftFile} ${rightFile} -o ${mergedFile}

## Thinkpad throttle fix
https://github.com/erpalma/lenovo-throttling-fix