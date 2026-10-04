#!/usr/bin/env bash
# Compila e instala flow-desktop-beta-bin desde este directorio.
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")"

if [[ ! -f PKGBUILD ]]; then
	echo "No se encuentra PKGBUILD en $(pwd)" >&2
	exit 1
fi

echo "==> [1/3] Instalando dependencias que falten (puede pedir sudo)…"
# -s sincroniza las dependencias declaradas en depends/optdepends.
makepkg -s --noconfirm --needed

echo "==> [2/3] Compilando el paquete…"
makepkg -f --noconfirm --noprogressbar

echo "==> [3/3] Instalando en el sistema…"
sudo pacman -U --noconfirm ./*.pkg.tar.zst

cat <<'EOF'

Listo. Flow Desktop Beta debería aparecer en el menú de aplicaciones.

  Arrancar desde la terminal : flow
  Registrar enlaces flow://   : xdg-mime default flow-beta.desktop x-scheme-handler/flow
  Desinstalar                : sudo pacman -Rns flow-desktop-beta-bin
EOF
