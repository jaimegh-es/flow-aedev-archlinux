<p align="center">
  <a href="https://flow-tube.org/">
    <img src="https://flow-tube.org/flow-icon.svg" alt="Flow logo" width="128" />
  </a>
</p>

# Flow Desktop AEDEV on Arch Linux

Flow Desktop (`v0.1.0-beta2`) packaged for Arch.

Upstream doesn't ship an Arch build — only `.AppImage`, `.deb` and `.rpm`. So I took
their official `.deb` and repackaged it. Same 11 MB instead of the AppImage's 156 MB,
because the `.deb` uses the system WebKitGTK instead of bundling its own copy.

## Install

To build and install from this repository in one command (downloads the repo archive, extracts it, builds and installs):

```bash
curl -L https://github.com/jaimegh-es/flow-aedev-archlinux/archive/refs/heads/main.tar.gz | tar xz \
  && cd flow-aedev-archlinux-main \
  && makepkg -s --noconfirm -i
```

If you prefer an interactive build step instead of the automatic install, run:

```bash
makepkg -s -si
```

## Update to a newer beta

Edit `_pkgver` and the `sha256` in `PKGBUILD`, then `makepkg -s -si`.

To get the checksum:

```bash
curl -sLO "https://github.com/Flow-Tube/Flow-Desktop/releases/download/v0.1.0-beta3/Flow_0.1.0-beta3_linux_amd64.deb"
sha256sum Flow_0.1.0-beta3_linux_amd64.deb
```

## Use

```bash
flow                                          # launch
xdg-mime default flow-beta.desktop x-scheme-handler/flow   # enable flow:// links
```

Your data and logs live in `~/.local/share/io.github.aedev.flow.desktop`. The app also
has *Settings → Diagnostics → Save logs*.

## Uninstall

```bash
sudo pacman -Rns flow-desktop-beta-bin
```

## AI
Made with free AI, tested and reviewed by human. :)
