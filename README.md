# MCreator .deb Builder


### Dependencies:

1. git
2. wget
3. libgtk-3-0
4. openjdk-21-jdk
5. dpkg

#### **NOTE:** You can install from Releases page, directly the .deb installer. 

## TO BUILD FROM SOURCE, FOLLOW THESE STEPS
1. Download the Linux Tarball from mcreator.net (eg. Mcreator-xyz.tar.xz)
2. Put the .tar.gz file in this folder
3. Run: 
   ```
   chmod +x build.sh
   ./build.sh
   ```
4. This will give output mcreator_2025XXX_amd64.deb in same folder
5. After that, run:
   ```
   sudo dpkg -i --force-depends mcreator_2025XX_amd64.deb
   ```
## Uninstall
1. Run:
   ```
   sudo dpkg -r mcreator
   sudo rm -rfv ~/.mcreator/
   sudo rm -rfv /opt/mcreator/
   ```
2. Run (change the version number):
   ```
   rm -rfv mcreator-2025XX # It is a folder
   ```
**NOTE: You can install dpkg package on Fedora, Arch Linux too and install MCreator**

---
