#!/bin/sh

VERSION="2.79"

echo "Pulling blender..."
mkdir /blender-git
cd /blender-git
wget "http://download.blender.org/source/blender-${VERSION}.tar.gz"
tar -xzf "blender-${VERSION}.tar.gz"
rm "blender-${VERSION}.tar.gz"
mv "blender-${VERSION}" blender

echo "Installing dependencies"
cd /blender-git
rm blender/build_files/build_environment/install_deps.sh
cp /blender_fix/install_deps.sh blender/build_files/build_environment/
echo "Y" | blender/build_files/build_environment/install_deps.sh --source=/blender-git/

echo "Building Blender..."
cd /blender-git/
PPATH="$(which python3)"
cmake blender \
    -DCMAKE_INSTALL_PREFIX=/usr/lib/python3/dist-packages \
    -DWITH_GAMEENGINE=ON \
    -DWITH_INSTALL_PORTABLE=OFF \
    -DWITH_GAMEENGINE=OFF \
    -DWITH_PYTHON_INSTALL=OFF \
    -DWITH_PLAYER=OFF \
    -DWITH_PYTHON_MODULE=ON \
    -DPYTHON_SITE_PACKAGES=/usr/lib/python3/dist-packages \
CORES="$(getconf _NPROCESSORS_ONLN)"
make -j $CORES
make install
