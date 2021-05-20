# yet Another Gamma Index Tool

Application and library for performing efficient comparisons of 2D, 3D DICOM images using gamma index concept.

This is early development version, some propreties are hardcoded in files and you need to do additional work in order to compile project.
To compile project, these steps needs to be done (other than having Visual Studio C and C++ compiler and Cmake):
1. Install Chocolatey by running this command:
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
in the command line
2. Install wget by running this command:
choco install wget
3. Add Msbuild to PATH variable: path to Msbuild {Visual Studio Install Folder}\2019\Community\MSBuild\Current\Bin
4. Install 7-Zip and add instalation folder to PATH variable
5. Run ./deploywin.sh in Bash console - i used GIT Bash
6. Run a .sln file you want by executing this command : msbuild {your file name}.sln


For all the details concerning the yAGIT project please see the [documentation](http://gi-yagit.readthedocs.io/en/latest/).
