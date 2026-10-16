<p align="center">
  <a href="https://flow-tube.org/">
    <img src="https://flow-tube.org/flow-icon.svg" alt="Flow logo" width="128" />
  </a>
</p>
<div align="center">
<h1> Flow Desktop AEDEV on Arch Linux</h1>
</div>

Flow, AEDEV's great invention, still does not have a version for arch linux, unless as of when this repo is created, so here I leave you the PKGBUILD to install it, AUR-style

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

The PKGBUILD downloads the latest Flow version from the Github repo!

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
