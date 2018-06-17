#!/bin/bash

function statusBanner
{
    echo ""
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "~ $*"
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo ""
}

statusBanner "This script will setup INDI on cygwin after cygwin and the dependencies are installed using the install.bat script"

read -p "Are you ready to proceed (y/n)? " proceed

if [ "$proceed" != "y" ]
then
	exit
fi

export LIBINDI_REPO=https://github.com/indilib/indi.git
export INDI_DIR=~/indi-stuff

mkdir -p ${INDI_DIR}
cd ${INDI_DIR}/

read -p "Do you need to install libnova (y/n)? " installNOVA

if [ "$installNOVA" == "y" ]
then
	statusBanner "Installing LibNova"
	wget -O libnova-0.15.0.tar.gz https://sourceforge.net/projects/libnova/files/libnova-0.15.0.tar.gz
	tar -xvzf libnova-0.15.0.tar.gz
	cd libnova-0.15.0
	autoreconf --install --symlink
	./configure --prefix=/usr/
	make
	make install
	statusBanner "LibNova is installed."
	cd ..
fi


if [ ! -d indi ]
then
	statusBanner "Cloning indi library"
	git clone ${LIBINDI_REPO}
	cd indi/libindi
else
	statusBanner "Updating indi"
	cd indi
	git pull
	cd ..
fi

mkdir -p ${INDI_DIR}/build/libindi
cd ${INDI_DIR}/build/libindi
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_CXX_FLAGS="-std=c++11 -U__STRICT_ANSI__" -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=TRUE -DBUILD_SHARED_LIBS=TRUE -DCMAKE_BUILD_TYPE=Debug ${INDI_DIR}/indi/libindi
make
make install

read -p "Do you need to install GPhoto (y/n)? " installGPhoto

if [ "$installGPhoto" == "y" ]
then

	mkdir -p ${INDI_DIR}/build/3rdparty/gphoto
	cd ${INDI_DIR}/build/3rdparty/gphoto
	git clone https://github.com/gphoto/libgphoto2.git
	cd libgphoto2
	autoreconf --install --symlink
	./configure --prefix=/usr/
	make
	make install

	cd ${INDI_DIR}/build/3rdparty/gphoto
	git clone https://github.com/gphoto/gphoto2.git
	cd gphoto2
	autoreconf --install --symlink
	./configure --prefix=/usr/
	make
	make install
fi

#Just GPhoto for now
mkdir -p ${INDI_DIR}/build/3rdParty/indi_gphoto
cd ${INDI_DIR}/build/3rdParty/indi_gphoto
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_CXX_FLAGS="-std=c++11 -U__STRICT_ANSI__" -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=TRUE -DBUILD_SHARED_LIBS=TRUE -DCMAKE_BUILD_TYPE=Debug ${INDI_DIR}/indi/3rdParty/indi_gphoto
make
make install

#mkdir -p ${INDI_DIR}/build/3rdParty
#cd ${INDI_DIR}/build/3rdParty 
#cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_CXX_FLAGS="-std=c++11 -U__STRICT_ANSI__" -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=TRUE -DBUILD_SHARED_LIBS=TRUE -DCMAKE_BUILD_TYPE=Debug ${INDI_DIR}/indi/3rdParty
#make
#make install

statusBanner "INDI is installed." 

read -p "Do you want to install GSC (200 MB) to have stars in your INDI CCD Simulator (y/n)? " installGSC

if [ "$installGSC" == "y" ]
then

	statusBanner "Downloading GSC" 
	mkdir ~/gsc
	cd ~/gsc
	wget -O bincats_GSC_1.2.tar.gz http://cdsarc.u-strasbg.fr/viz-bin/nph-Cat/tar.gz?bincats/GSC_1.2
	tar -xvzf bincats_GSC_1.2.tar.gz
	cd src
	make
	statusBanner "Please excuse the error above, it will not affect the installation."

	mv a.exe gsc.exe
	cp gsc.exe /usr/bin/

	cd ..
	cp ~/gsc/bin/regions.* ~/gsc

	cp ~/.bashrc ~/.bashrc.copy
	echo "export GSCDAT=~/gsc" >> ~/.bashrc

	statusBanner "GSC is installed"
fi