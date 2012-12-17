#!/bin/sh

yaourt -S android-sdk android-sdk-platform-tools android-udev fastboot
sudo gpasswd -a `whoami` adbusers
