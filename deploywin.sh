#!/bin/bash

# This file is part of 'yet Another Gamma Index Tool'.
#
# 'yet Another Gamma Index Tool' is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# 'yet Another Gamma Index Tool' is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with 'yet Another Gamma Index Tool'; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

if [ -d "wxWidgets" ]; then
  echo 'WxWidgets is already installed, skip building wxWidgets'
else
  echo "Installing wxWidgets"
	mkdir wxWidgets
	cd wxWidgets
	wget https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.5/wxWidgets-3.1.5-headers.7z
	7z x wxWidgets-3.1.5-headers.7z
	wget https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.5/wxMSW-3.1.5_vc14x_x64_Dev.7z
	7z x wxMSW-3.1.5_vc14x_x64_Dev.7z
	wget https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.5/wxMSW-3.1.5_vc14x_x64_ReleaseDLL.7z
	7z x wxMSW-3.1.5_vc14x_x64_ReleaseDLL.7z
	cd ..
fi



if [ -d "imebra" ]; then
  echo 'Imebra is already installed, skip building Imebra'
else
  echo "Building imebra"
  mkdir imebra
  cd imebra
  wget https://github.com/binarno/imebra_mirror/archive/refs/heads/4.0.8.zip
  7z x 4.0.8.zip
  cd imebra_mirror-4.0.8/
  cp -a . ..
  cd ..
  mkdir artifacts
  cd artifacts
  cmake ../library -DIMEBRA_SHARED_STATIC=STATIC
  cmake --build .
  cd ..
  cd ..
fi

echo "Starting build"
echo "Building core module"
cd gi_core
cmake build .
cd ..
echo "Building additions module"
cd gi_additions
cmake build .
cd ..
echo "Building wrapper module"
cd gi_wrapper_cpp
cmake build .
cd ..
cd examples
echo "Building examples"
cmake build . 
cd ..
cd gi_gui
cmake build .
cd ..
echo "Finish building"
