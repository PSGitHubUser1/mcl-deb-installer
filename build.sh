#!/bin/bash
set -e
PKG_NAME="mcreator"
ARCH="amd64"

# Find Tarball
TARBALL=$(find . -maxdepth 1 -name "MCreator*.tar.gz" -o -name "MCreator*.tar.xz" | head -n 1)
if [ -z "$TARBALL" ]; then
    echo "Error: No MCreator tarball found! Put the .tar.gz file here."
    exit 1
fi

# Get Version
VERSION=$(echo "$TARBALL" | grep -oP '\d{4}\.\d+')
[ -z "$VERSION" ] && read -p "Enter Version (e.g., 2025.4): " $VERSION

# Build
rm -rf build_area
mkdir -p build_area/DEBIAN build_area/opt/mcreator build_area/usr/bin build_area/usr/share/applications

echo "Extracting..."
tar -xf "$TARBALL" -C "build_area/opt/mcreator" --strip-components=1

# Create Control File
SIZE=$(du -ks build_area | cut -f1)
cat > build_area/DEBIAN/control <<CONTROL
Package: $PKG_NAME
Version: $VERSION
Architecture: $ARCH
Maintainer: Shubham
Depends: git, wget, libgtk-3-0, openjdk-21-jdk
Description: MCreator Mod Maker
Installed-Size: $SIZE
CONTROL

# Wrapper
echo -e '#!/bin/bash\ncd /opt/mcreator\n./mcreator.sh "$@"' > build_area/usr/bin/mcreator
chmod 755 build_area/usr/bin/mcreator

# Desktop File
echo "[Desktop Entry]
Type=Application
Name=MCreator
Exec=/usr/bin/mcreator
Icon=mcreator
Categories=Development;" > build_area/usr/share/applications/mcreator.desktop

# Permissions
chmod -R 755 build_area/opt/mcreator

# Final Deb
dpkg-deb --build build_area "${PKG_NAME}_${VERSION}_${ARCH}.deb"
rm -rf build_area
echo "Done! Created ${PKG_NAME}_${VERSION}_${ARCH}.deb"
