# iSpotify Releases

Official Windows and Linux downloads for **iSpotify**, a desktop music search, playback, and download application.

## Windows

The Windows installer is recommended for most users. A standalone portable executable is also attached to each release.

After the WinGet package is accepted, install it with:

```powershell
winget install ISpotify.ISpotify
```

## Linux

Install the latest release and add iSpotify to your desktop application menu:

```bash
curl -fsSL https://github.com/itzlalpekhlua/ISpotify-Releases/releases/latest/download/install.sh | bash
```

This installs only for the current user and does not require root. Uninstall it with:

```bash
curl -fsSL https://github.com/itzlalpekhlua/ISpotify-Releases/releases/latest/download/install.sh | bash -s -- --uninstall
```

You can also install a specific version:

```bash
curl -fsSL https://github.com/itzlalpekhlua/ISpotify-Releases/releases/latest/download/install.sh | ISPOTIFY_VERSION=16.2.0 bash
```

For a manual installation, download `ISpotify-linux-x86_64`, make it executable, and run it:

```bash
chmod +x ISpotify-linux-x86_64
./ISpotify-linux-x86_64
```

The executable supports 64-bit Linux systems with glibc 2.36 or newer. It has been launch-tested on Arch Linux. A normal desktop installation usually has the required GUI libraries. On a minimal Arch installation, install them with:

```bash
sudo pacman -S --needed mesa libxkbcommon fontconfig libx11 libxcb libpulse alsa-lib dbus
```

## Verification

Every release includes SHA-256 checksum files.

Windows PowerShell:

```powershell
Get-FileHash .\ISpotify-Setup-x86_64.exe -Algorithm SHA256
```

Linux:

```bash
sha256sum -c ISpotify-linux-x86_64.sha256
```

## Privacy and source

This repository contains release binaries and public documentation only. The application source is maintained separately in a private repository.

## Support

Report application or installation problems through this repository's issue tracker.
