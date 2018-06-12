@ECHO OFF
REM -- Automates cygwin installation and automatically gets the system set up for INDI Installation

SETLOCAL

REM -- Change to the directory of the executing batch file
CD %~dp0

REM -- Configure our paths
SET SITE=http://mirrors.kernel.org/sourceware/cygwin/
SET LOCALDIR=%LOCALAPPDATA%/cygwin64
SET ROOTDIR=C:/cygwin64

REM -- These are the packages we will install (in addition to the default packages)
SET PACKAGES=mintty,wget,git,git-completion,git-svn,p7zip,gcc-core,gcc-g++,cmake,make,automake,autoconf,ninja
SET PACKAGES=%PACKAGES%,zlib-devel,gettext,python,python3,bison,shared-mime-info,libtool
SET PACKAGES=%PACKAGES%,libftdi,eigen,gsl,boost,libboost-devel,libcairo2,libcairo-devel,cfitsio,libcfitsio-devel
SET PACKAGES=%PACKAGES%,libjpeg-devel,libjpeg-turbo,dcraw,libraw-devel,libtheora-devel,libtiff,libncursesw-devel,libiconv,libfftw3

REM -- Do it!
ECHO *** INSTALLING PACKAGES
setup-x86_64.exe --no-admin -q -D -L -g -o -s %SITE% -l "%LOCALDIR%" -R "%ROOTDIR%" -C Base -P %PACKAGES%

REM -- Copying in the package installer.
copy setup-x86_64.exe "%ROOTDIR%"/bin/setup-x86_64.exe
copy install-pkg "%ROOTDIR%"/bin/install-pkg
copy buildINDI.sh "%ROOTDIR%"/bin/buildINDI.sh

REM -- Show what we did
ECHO.
ECHO.
ECHO cygwin installation updated
ECHO  - %PACKAGES%
ECHO.

ENDLOCAL

PAUSE
EXIT /B 0