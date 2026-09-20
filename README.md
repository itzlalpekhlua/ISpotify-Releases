# iSpotify Releases

Official Windows and Linux packages for [iSpotify](https://github.com/itzlalpekhlua/ISpotify), a local desktop music search, playlist, download, and playback application.

## Windows

Download `ISpotify-Setup-x86_64.exe` from the [latest release](https://github.com/itzlalpekhlua/ISpotify-Releases/releases/latest). A portable executable is also available.

The WinGet submission is under review. When accepted, the install command will be:

```powershell
winget install ISpotify.ISpotify
```

## Linux installer

Install the latest release for the current user and register it in the desktop application menu:

```bash
curl -fsSL https://github.com/itzlalpekhlua/ISpotify-Releases/releases/latest/download/install.sh | bash
```

Check compatibility and update status without changing the computer:

```bash
curl -fsSL https://github.com/itzlalpekhlua/ISpotify-Releases/releases/latest/download/install.sh | bash -s -- --check
```

Uninstall with:

```bash
curl -fsSL https://github.com/itzlalpekhlua/ISpotify-Releases/releases/latest/download/install.sh | bash -s -- --uninstall
```

## Debian and Ubuntu

```bash
curl -fsSL https://github.com/itzlalpekhlua/ISpotify-Releases/releases/latest/download/ispotify-archive-keyring.gpg \
  | sudo tee /usr/share/keyrings/ispotify-archive-keyring.gpg >/dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/ispotify-archive-keyring.gpg] https://github.com/itzlalpekhlua/ISpotify-Releases/releases/latest/download ./" \
  | sudo tee /etc/apt/sources.list.d/ispotify.list
sudo apt update
sudo apt install ispotify
```

## Arch Linux

```bash
curl -fsSL https://github.com/itzlalpekhlua/ISpotify-Releases/releases/latest/download/ispotify-archive-keyring.asc \
  -o /tmp/ispotify-archive-keyring.asc
sudo pacman-key --add /tmp/ispotify-archive-keyring.asc
sudo pacman-key --lsign-key 1D5A2FE0A948FA1944BB17B391C8400E2B908FE7
printf '\n[ispotify]\nSigLevel = Required DatabaseOptional\nServer = https://github.com/itzlalpekhlua/ISpotify-Releases/releases/latest/download\n' \
  | sudo tee -a /etc/pacman.conf
sudo pacman -Syu ispotify
rm /tmp/ispotify-archive-keyring.asc
```

Linux packages target x86-64 with glibc 2.36 or newer. The v17 package has been launch-tested in clean Debian 12 and Arch Linux containers.

## Verification

Standalone executable packages include SHA-256 checksum files. The APT and Arch repositories are signed by key `1D5A2FE0A948FA1944BB17B391C8400E2B908FE7`.

Source code, contribution guidance, and issue templates are in the [public source repository](https://github.com/itzlalpekhlua/ISpotify).
