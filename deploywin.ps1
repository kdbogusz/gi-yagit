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

if(Get-Module -ListAvailable -Name 7Zip4Powershell){
	echo "7Zip for Powershell installed, skipping install"
}
else{
	echo "7Zip for Powershell not installed, installing right now"
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
	Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
	Set-PSRepository -Name 'PSGallery' -SourceLocation "https://www.powershellgallery.com/api/v2" -InstallationPolicy Trusted
	Install-Module -Name 7Zip4PowerShell -Force
}

if ( Test-Path -Path wxWidgets ){
  echo 'WxWidgets is already installed, skip building wxWidgets'
}
else{
  echo "Installing wxWidgets"
	mkdir wxWidgets
	cd wxWidgets
	wget -UseBasicParsing https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.5/wxWidgets-3.1.5-headers.7z -outfile "wxWidgets-3.1.5-headers.7z"
	Expand-7Zip wxWidgets-3.1.5-headers.7z -TargetPath .
	wget -UseBasicParsing https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.5/wxMSW-3.1.5_vc14x_x64_Dev.7z -outfile "wxMSW-3.1.5_vc14x_x64_Dev.7z"
	Expand-7Zip wxMSW-3.1.5_vc14x_x64_Dev.7z -TargetPath .
	wget -UseBasicParsing https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.5/wxMSW-3.1.5_vc14x_x64_ReleaseDLL.7z -outfile "wxMSW-3.1.5_vc14x_x64_ReleaseDLL.7z"
	Expand-7Zip wxMSW-3.1.5_vc14x_x64_ReleaseDLL.7z -TargetPath .
	cd ..
}

if ( Test-Path -Path imebra ){
  echo 'Imebra is already installed, skip building Imebra'
}
else{
  echo "Building imebra"
  mkdir imebra
  cd imebra
  wget -UseBasicParsing https://github.com/binarno/imebra_mirror/archive/refs/heads/4.0.8.zip -outfile "4.0.8.zip"
  Expand-Archive -Path .\4.0.8.zip -DestinationPath .
  cd imebra_mirror-4.0.8/
  Copy-Item -Path * -Destination .. -Recurse
  cd ..
  mkdir artifacts
  cd artifacts
  cmake ../library -DIMEBRA_SHARED_STATIC=STATIC
  cmake --build .
  cd ..
  cd ..
}

echo "Starting build"
echo "Building core module"
cd gi_core
cmake build . -B build
msbuild build/gi_core.sln
cd ..
echo "Building additions module"
cd gi_additions
cmake build . -B build
msbuild build/gi_additions.sln
cd ..
echo "Building wrapper module"
cd gi_wrapper_cpp
cmake build . -B build
msbuild build/gi_wrapper_cpp.sln
cd ..
cd examples
echo "Building examples"
cmake build . -B build
msbuild build/examples.sln
cd ..
cd gi_gui
cmake -D wxWidgets_ROOT_DIR:PATH=../wxWidgets/ build . -B build
msbuild build/yAGIT.sln
cd ..
echo "Finish building"
