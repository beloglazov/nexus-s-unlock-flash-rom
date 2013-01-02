# A step-by-step guide to unlocking Nexus S and flashing a custom ROM

This guide assumes that you are using Linux, and specifically tailored to Arch Linux (however, can
also be applied to other Linux distribution by modifying `01-install-tools.sh`). More information
can be found on the XDA Wiki: http://forum.xda-developers.com/wiki/Flashing_Guide_-_Android

First of all, I'd like to clarify the difference between unlocking the bootloader, flashing a ROM,
and rooting the phone, since it's often the source of confusion. The bootloader is a small program
that boots either the Android ROM, or the recovery mode installed on the phone. Unlocking the
bootloader allows installing custom ROMs and recoveries, which would fail to boot from a locked
bootloader.

The ROM and recovery of a phone are installed on separate partitions; therefore, replacing one of
them does not affect the other. This means that even if you flash a faulty ROM, it won't affect the
operation of the recovery. The recovery mode can then be used to flash a new ROM and fix the phone.
The recovery mode enables certain operations on the phone, such as flashing a new ROM, doing a
factory reset, wiping the cache partition, as well as backing up and restoring the current ROM.

Rooting is not related and actually not required for flashing a ROM. Rooting is done on an already
operating ROM by installing an `su` binary and Superuser app, which together allow granting the root
permissions to other apps. The root permissions enable such functions as overclocking the CPU,
modifying the hardware button actions, etc.

The general procedure of installing a custom ROM consists of the following steps:

1. Unlocking the bootloader to allow booting non-standard ROMs and recovery modes.
2. Flashing a custom recovery, such as the ClockworkMod Recovery (CWM).
3. Downloading a custom ROM and flashing it using the installed custom recovery mode.


## Steps for unlocking and flashing a custom ROM on Nexus S

These steps assume that you are using Arch Linux. For other Linux distributions, you just need to
modify Step 2 to install the tools using your package manager. The commands that need to be run on
the computer can be run manually, or by cloning this repository and using the included scripts.

1. Backup the phone's data, as the following steps will wipe everything.
2. [This is Arch Linux specific] Install the Android SDK and other tools, such as `fastboot`, by
   running:

    ```Shell
    yaourt -S android-sdk android-sdk-platform-tools android-udev fastboot
    sudo gpasswd -a `whoami` adbusers
    ```

    or if you cloned the repository, just run `./01-install-tools.sh`

3. Turn off the phone, connect it by USB to the computer, and boot into the bootloader interface by
   holding the Volume UP and Power buttons simultaneously.
4. The bootloader should now show "LOCK STATUS - LOCKED", which means unlocking is required.
5. Unlock the bootloader by running from the command line:

    ```Shell
    fastboot oem unlock
    ```

    or just running `./02-unlock-bootloader.sh`

6. Download the ClockworkMod Recovery (CWM) by running:

    ```Shell
    wget http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-crespo.img
    ```

    or just running `./03-download-recovery.sh`

7. Flash CWM by running:

    ```Shell
    fastboot flash recovery recovery-clockwork-6.0.1.0-crespo.img
    ```

    or just running `./04-flash-recovery.sh`

8. Boot the recovery mode by selecting it from the bootloader's menu using the volume and power
   buttons.
9. Select "Wipe data/factory reset".
10. Select "Wipe cache partition".
11. Select "Advanced", and then "Wipe Dalvik Cache".
12. In this step, you need to download a custom ROM. I suggest using either the Oxygen ROM or
    CyanogenMod. At the moment, I'm using the Oxygen ROM:

    ```Shell
    wget http://download.oxygen.im/roms/update-oxygen-2.3.2-NS-signed.zip
    adb push update-oxygen-2.3.2-NS-signed.zip /sdcard
    ```

    or just run `./05-download-oxygen-rom.sh`. This will download the ROM and upload it to the
    phone's SD Card.

	UPDATE (02/01/2013): since http://oxygen.im is not available anymore, I've added the Oxygen ROM
	archive to this repository.

	If you want, you can download and use the CyanogenMod ROM:

    ```Shell
    wget http://download.cyanogenmod.org/get/jenkins/2821/cm-7.2.0-crespo.zip
    adb push cm-7.2.0-crespo.zip /sdcard
    ```

    or just run `./05-download-cyanogenmod.sh`

	Both ROMs are rooted by default.

13. Flash the downloaded ROM using CWM's menu: install from sdcard -> choose zip from sdcard ->
    choose the downloaded zip file.
14. You may also want to install the latest versions of Google Apps, which include Play Store,
    GTalk, etc. This is required for CyanogenMod since it does not come with these apps by default.
    However, it is also useful for Oxygen since it comes with older versions of the apps. A package
    with the apps can be downloaded and pushed to the phone by running:

    ```Shell
	wget http://goo.im/gapps/gapps-gb-20110828-newtalk-signed.zip
	adb push gapps-gb-20110828-newtalk-signed.zip /sdcard
    ```

    or just running `./06-download-gapps.sh`

15. Flash the package with the apps using CWM's menu: install from sdcard -> choose zip from sdcard
    -> choose the downloaded gapps-gb-20110828-newtalk-signed.zip file.
16. Now choose "reboot system now" to reboot the phone.
17. Enjoy a new rooted custom ROM on your phone!


## Why you would want to flash an old version of Android?

As you may have noticed, I flashed a Gingerbread version (2.3) of both Oxygen and CyanogenMod. Why
would you do that when there is 4.2 already out there? The reason is that the new versions, such as
4.*, were not built for old hardware, which Nexus S is. At some point, I couldn't tolerate the
slowness of my Nexus S on 4.1 anymore - it literally couldn't manage to display the name of person
calling in several seconds!

Flashing a custom ROM based on Gingerbread was a solution: Nexus S feels like a new phone now, it's
much faster than on 4.1, and even the battery life has improved significantly! If you have the same
problem, try flashing Oxygen as suggested in this guide, and you will feel the difference :)


## Disclaimer

I am not responsible for any problems caused by following the above guide, follow at your own risk.
