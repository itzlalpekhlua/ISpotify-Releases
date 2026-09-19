#!/usr/bin/env bash
set -Eeuo pipefail

REPOSITORY="itzlalpekhlua/ISpotify-Releases"
APP_NAME="iSpotify"
ASSET_NAME="ISpotify-linux-x86_64"
ICON_NAME="ispotify-logo.png"

data_home="${XDG_DATA_HOME:-$HOME/.local/share}"
bin_home="${XDG_BIN_HOME:-$HOME/.local/bin}"
app_dir="$data_home/ispotify"
application_dir="$data_home/applications"
icon_dir="$data_home/icons/hicolor/256x256/apps"
executable="$app_dir/ISpotify"
launcher="$bin_home/ispotify"
desktop_file="$application_dir/ispotify.desktop"
icon_file="$icon_dir/ispotify.png"

say() {
  printf 'iSpotify: %s\n' "$*"
}

remove_installation() {
  rm -f -- "$launcher" "$desktop_file" "$icon_file" "$executable"
  rmdir -- "$app_dir" 2>/dev/null || true
  command -v update-desktop-database >/dev/null 2>&1 \
    && update-desktop-database "$application_dir" >/dev/null 2>&1 \
    || true
  command -v gtk-update-icon-cache >/dev/null 2>&1 \
    && gtk-update-icon-cache -f -t "$data_home/icons/hicolor" >/dev/null 2>&1 \
    || true
  say "removed from this user account"
}

if [[ "${1:-}" == "--uninstall" ]]; then
  remove_installation
  exit 0
fi

if [[ "$(uname -s)" != "Linux" ]]; then
  say "this installer only supports Linux"
  exit 1
fi

case "$(uname -m)" in
  x86_64|amd64) ;;
  *)
    say "this release requires a 64-bit x86 processor"
    exit 1
    ;;
esac

if ! command -v sha256sum >/dev/null 2>&1; then
  say "sha256sum is required"
  exit 1
fi

download() {
  local url="$1"
  local destination="$2"
  if command -v curl >/dev/null 2>&1; then
    curl --fail --location --silent --show-error "$url" --output "$destination"
  elif command -v wget >/dev/null 2>&1; then
    wget --quiet "$url" --output-document="$destination"
  else
    say "curl or wget is required"
    exit 1
  fi
}

requested_version="${ISPOTIFY_VERSION:-latest}"
if [[ "$requested_version" == "latest" ]]; then
  release_base="https://github.com/$REPOSITORY/releases/latest/download"
  installed_version="latest"
else
  tag="$requested_version"
  [[ "$tag" == v* ]] || tag="v$tag"
  release_base="https://github.com/$REPOSITORY/releases/download/$tag"
  installed_version="${tag#v}"
fi

temporary_dir="$(mktemp -d)"
trap 'rm -rf -- "$temporary_dir"' EXIT

say "downloading $APP_NAME $installed_version"
download "$release_base/$ASSET_NAME" "$temporary_dir/$ASSET_NAME"
download "$release_base/$ASSET_NAME.sha256" "$temporary_dir/$ASSET_NAME.sha256"
download "$release_base/$ICON_NAME" "$temporary_dir/$ICON_NAME"

(
  cd "$temporary_dir"
  sha256sum --check --status "$ASSET_NAME.sha256"
) || {
  say "download checksum verification failed"
  exit 1
}

install -d -- "$app_dir" "$bin_home" "$application_dir" "$icon_dir"
install -m 755 -- "$temporary_dir/$ASSET_NAME" "$executable"
install -m 644 -- "$temporary_dir/$ICON_NAME" "$icon_file"
ln -sfn -- "$executable" "$launcher"

cat >"$desktop_file" <<EOF
[Desktop Entry]
Type=Application
Version=1.0
Name=iSpotify
Comment=Search, play, and download music
Exec="$executable"
Icon=$icon_file
Terminal=false
Categories=AudioVideo;Audio;Player;
StartupNotify=true
EOF

chmod 644 "$desktop_file"
command -v update-desktop-database >/dev/null 2>&1 \
  && update-desktop-database "$application_dir" >/dev/null 2>&1 \
  || true
command -v gtk-update-icon-cache >/dev/null 2>&1 \
  && gtk-update-icon-cache -f -t "$data_home/icons/hicolor" >/dev/null 2>&1 \
  || true

say "installed successfully"
say "open iSpotify from the application menu or run: $launcher"
if [[ ":$PATH:" != *":$bin_home:"* ]]; then
  say "add $bin_home to PATH to run 'ispotify' directly"
fi
