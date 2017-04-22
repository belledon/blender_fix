#!/bin/sh

mkdir /blender-git 
cd /blender-git 
git clone https://git.blender.org/blender.git 
cd blender 
git submodule update --init --recursive 
git submodule foreach git checkout master 
git submodule foreach git pull --rebase origin master

cd ..
git clone https://github.com/belledon/blender_fix.git
rm blender/build_files/build_environment/install_deps.sh
cp blender_fix/install_deps.sh blender/build_files/build_environment/
./install_deps.sh --source=/blender-git/

cmake ../blender \
    -DCMAKE_INSTALL_PREFIX=/opt/blender \
    -DWITH_INSTALL_PORTABLE=OFF \
    -DWITH_GAMEENGINE=OFF \
    -DWITH_PYTHON_INSTALL=OFF \
    -DWITH_PLAYER=OFF \
    -DWITH_PYTHON_MODULE=ON \
    -DPYTHON_SITE_PACKAGES=
