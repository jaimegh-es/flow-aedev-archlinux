# Flow Desktop AEDEV on Arch Linux

Flow Desktop (`v0.1.0-beta2`) packaged for Arch.

Upstream doesn't ship an Arch build — only `.AppImage`, `.deb` and `.rpm`. So I took
their official `.deb` and repackaged it. Same 11 MB instead of the AppImage's 156 MB,
because the `.deb` uses the system WebKitGTK instead of bundling its own copy.

## Install

Already installed. To do it again from scratch:

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

## One note if you ever rebuild it

The binary looks for its `integrity.cjs` sidecar by walking up from `/proc/self/exe`.
Upstream ships it somewhere that path never reaches, so this package puts the binary in
`/usr/lib/flow-desktop/` and symlinks `/usr/bin/flow` to it — `/proc/self/exe` resolves
symlinks, so the sidecar gets found. Don't "simplify" that back to a plain
`/usr/bin/flow` or PO token minting silently stops working.  

## AI
Made with free AI, tested and reviewed by human. :)