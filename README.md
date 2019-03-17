adb-backup
========

adb-backup is a tool to back up files from an Android device to a PC using
the ADB (Android Debug Bridge).

Setup
=====

Android Side
------------

First you need to enable USB debugging mode. This allows authorized computers
(on Android before 4.4.3 all computers) to perform possibly dangerous
operations on your device. If you do not accept this risk, do not proceed and
try using [go-mtpfs](https://github.com/hanwen/go-mtpfs) instead!

On your Android device:

* Go to the Settings app.
* If there is no "Developer Options" menu:
  * Select "About".
  * Tap "Build Number" seven times.
  * Go back.
* Go to "Developer Options".
* Enable "USB Debugging".

PC Side
-------

* `git clone https://github.com/mmousawy/adb-backup`
* `cd adb-backup`

Usage
=====

Make sure to edit `config.txt` and add the folder locations for source -> 
destination.

Example:
```
; Backup the default camera folder
"/sdcard/DCIM/Camera" "F:\backup"

; Backup messenger images
"/sdcard/WhatsApp/Media/WhatsApp Images" "F:\backup"
"/sdcard/Telegram/Telegram Images" "F:\backup"
```

To start the backup, browse to the project folder and type in terminal:

```bash
# Windows: 
.\win-backup.bat

# TODO: Mac
./mac-backup.sh

# TODO: Linux
./linux-backup.sh
```
