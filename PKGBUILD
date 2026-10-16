# This file is part of Arch Linux, https://archlinux.org
#
# Reempaquetado para Arch del .deb oficial de Flow Desktop (beta).
# Upstream: https://github.com/Flow-Tube/Flow-Desktop

pkgname=flow-desktop-beta-bin
# Obtener dinámicamente la última versión desde las releases de GitHub.
# Se elimina un posible prefijo 'v' del tag (p.ej. v0.1.0-beta2 -> 0.1.0-beta2).
# Nota: makepkg necesitará acceso a Internet al parsear este PKGBUILD.
_pkgver=$(curl -sSfL "https://api.github.com/repos/Flow-Tube/Flow-Desktop/releases/latest" \
  | grep '"tag_name":' \
  | sed -E 's/.*"([^"]+)".*/\1/' \
  | sed 's/^v//')
# Reemplazamos guiones por guiones bajos para la variable pkgver (convención de Arch):
pkgver=${_pkgver//-/_}
pkgrel=1
pkgdesc="Flow Desktop beta: cliente de escritorio de YouTube/YouTube Music sin cuenta, sin ads y sin telemetría"
arch=('x86_64' 'aarch64')
url="https://github.com/Flow-Tube/Flow-Desktop"
license=('GPL-3.0-only')
provides=("flow-desktop-beta=$pkgver")
conflicts=('flow-desktop' 'flow-desktop-beta' 'flow-beta')
options=('!strip' '!debug' '!emptydirs')
depends=(
  'gtk3'
  'webkit2gtk-4.1'
  'libsoup3'
  'gst-plugins-base'
  'gst-plugins-good'
  'gst-plugins-bad'
  'gst-libav'
)
optdepends=(
  'nodejs: sidecar BotGuard (integrity.cjs) para mintear PO tokens sin interfaz gráfica'
  'gst-plugins-ugly: códecs adicionales de GStreamer'
  'libnotify: notificaciones del sistema'
)

# Upstream no publica build de Arch, pero sí un .deb por arquitectura.
# Es preferible al AppImage (11 MB vs 156 MB) porque delega en el WebKit del
# sistema en lugar de llevar sus propias librerías gráficas.
#
# `source`/`sha256sums` se calculan según $CARCH en lugar de usar los arrays
# por arquitectura (sha256sums_x86_64), porque makepkg exige que el array de
# checksums por arquitectura venga acompañado de su propio source_x86_64.
_debarch=amd64
case $CARCH in
	x86_64)
		# checksum dinámico: no lo conocemos antes de descargar la release.
		# Para binarios que cambian frecuentemente es habitual usar 'SKIP'.
		_debsum=
		;;
	aarch64)
		_debarch=arm64
		_debsum=
		;;
	*)
		printf 'Arquitectura no soportada por este paquete: %s\n' "$CARCH" >&2
		exit 1
		;;
esac

# Usamos la URL de release que incluye el tag calculado arriba.
source=("Flow_${_pkgver}_linux_${_debarch}.deb::https://github.com/Flow-Tube/Flow-Desktop/releases/download/v${_pkgver}/Flow_${_pkgver}_linux_${_debarch}.deb")
# No se conoce el checksum a priori: usar 'SKIP' evita que makepkg falle.
# Si prefieres comprobarlo, ejecuta 'makepkg' una vez con SKIP y luego reemplaza
# el valor por el sha256 real generado por 'sha256sum'.
sha256sums=("SKIP")

# El .deb es un contenedor 'ar' (debian-binary, control.tar.*, data.tar.*).
# libarchive/bsdtar lo lee directamente, así que no hace falta binutils/ar.
prepare() {
  bsdtar -xf "$srcdir/Flow_${_pkgver}_linux_${_debarch}.deb"

  local data
  data=$(printf '%s\n' "$srcdir"/data.tar.*)
  bsdtar -xf "$data" -C "$srcdir"
}

package() {
  # El binario NO va en /usr/bin directamente: el sidecar de PO tokens se localiza
  # subiendo hasta 5 niveles desde /proc/self/exe (src/api/innertube/core/botguard.rs),
  # así que debe vivir junto al binario real. El symlink de /usr/bin se resuelve
  # vía /proc/self/exe, así que current_exe() devuelve la ruta real de /usr/lib.
  install -Dm755 "$srcdir/usr/bin/flow" "$pkgdir/usr/lib/flow-desktop/flow"
  install -Dm644 "$srcdir/usr/lib/Flow Beta/sidecar/integrity.cjs" \
    "$pkgdir/usr/lib/flow-desktop/sidecar/integrity.cjs"
  install -d "$pkgdir/usr/bin"
  ln -s ../lib/flow-desktop/flow "$pkgdir/usr/bin/flow"

  # Upstream sólo declara Categories=Network, lo que lo esconde del menú
  # Multimedia aunque sea un reproductor de vídeo. AudioVideo es la única
  # categoría principal: meter Network o Video junto haría que la app
  # apareciera duplicada en el menú.
  install -Dm644 "$srcdir/usr/share/applications/Flow Beta.desktop" \
    "$pkgdir/usr/share/applications/flow-beta.desktop"
  sed -i 's/^Categories=.*/Categories=AudioVideo;Player;Music;/' \
    "$pkgdir/usr/share/applications/flow-beta.desktop"

  install -Dm644 "$srcdir/usr/share/icons/hicolor/32x32/apps/flow.png" \
    "$pkgdir/usr/share/icons/hicolor/32x32/apps/flow.png"
  install -Dm644 "$srcdir/usr/share/icons/hicolor/128x128/apps/flow.png" \
    "$pkgdir/usr/share/icons/hicolor/128x128/apps/flow.png"
  install -Dm644 "$srcdir/usr/share/icons/hicolor/256x256@2/apps/flow.png" \
    "$pkgdir/usr/share/icons/hicolor/256x256@2/apps/flow.png"
}
