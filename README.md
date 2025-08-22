# RetroPie-Quick-Setup

## Overview

---
This guide is a step by step guide to creating a dedicated RetroPie Box. This is intended for Raspberry Pi but will work on other single board devices and or PC.

### Requirements

---

* Raspberry Pi (ideally 3 or greater) (can be any other Device/PC you have on hand.)
  * **Heads up:** Some Raspbery Pi versions already have a prebuilt image so go to the [RetroPie website](https://retropie.org.uk/download/) and check. If this applies to your Raspberry Pi, you can just ignore this guide and get the prebuilt image.
* MicroSD card reader for your PC
* HDMI, display/TV
* USB or Bluetooth game controller
* USB keyboard (for setup)
* MicroSD card (32GB+ recommended, Class 10 or better)
* Power supply
* Ethernet or Wi-Fi connection

---

### Step 1: Prepare the SD Card

1. **Flash the OS to the SD card**
   Use [Raspberry Pi Imager](https://www.raspberrypi.com/software/) or [Balena Etcher](https://etcher.io).

    * **Guide:**
        * [Raspberry Pi Imager](https://www.raspberrypi.com/documentation/computers/getting-started.html#raspberry-pi-imager)

    * **Important**
        * Make sure to set the administrator user as ```pi``` when setting up customizations through imager.

### Step 2: Copy/Paste then Run ```.retropie_install.sh```

* SSH into your device and copy/paste ```.retropie_install.sh```

* Make the script to executable ```chmod 700 .retropie_install.sh```

* Run script ```sudo ./.retropie_install.sh```

### Setp 3: Loads your Roms

* Load your Roms onto `/home/pi/RetroPie/roms/[system_name]`

### Step 4: Optional Enhancements

* Overclock the Pi via `raspi-config` (if using active cooling)
* Install `xpadneo` for Xbox wireless controller support
* Add themed bezels, overlays, and shaders.
* Backup your setup using tools like `rsync` or image the SD card with **Win32 Disk Imager**, or `dd` on linux.
