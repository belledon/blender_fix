#!/bin/sh

echo "Pulling blender..."
mkdir /blender-git
cd /blender-git
git clone https://git.blender.org/blender.git
cd blender
git submodule update --init --recursive
git submodule foreach git checkout master
git submodule foreach git pull --rebase origin master

echo "Installing dependencies"
cd /blender-git
rm blender/build_files/build_environment/install_deps.sh
cp /blender_fix/install_deps.sh blender/build_files/build_environment/
echo "Y" | blender/build_files/build_environment/install_deps.sh --source=/blender-git/

echo "Building Blender..."
cd /blender-git/
cmake blender \
    -DCMAKE_INSTALL_PREFIX=/usr/lib/python3/dist-packages \
    -DWITH_INSTALL_PORTABLE=OFF \
    -DWITH_GAMEENGINE=OFF \
    -DWITH_PYTHON_INSTALL=OFF \
    -DWITH_PLAYER=OFF \
    -DWITH_PYTHON_MODULE=ON \
    -DPYTHON_SITE_PACKAGES=/usr/lib/python3/dist-packages
    -DPYTHON_LIBRARY=/usr/bin/python3.5m
    -DPYTHON_INCLUDE_DIR=/usr/include/python3.5m
make
make install
