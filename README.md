# iSpotify Releases

Official Windows downloads for **iSpotify**, a desktop music search, playback, and download application.

## Install

The Windows installer is recommended for most users. A standalone portable executable is also attached to each release.

After the WinGet package is accepted, install it with:

```powershell
winget install ISpotify.ISpotify
```

## Verification

Every release includes SHA-256 checksum files. Compare a download with PowerShell:

```powershell
Get-FileHash .\ISpotify-Setup-x86_64.exe -Algorithm SHA256
```

## Privacy and source

This repository contains release binaries and public documentation only. The application source is maintained separately in a private repository.

## Support

Report application or installation problems through this repository's issue tracker.

