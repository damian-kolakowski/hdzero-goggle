#!/bin/bash
set -e

if [ ! -d linux-4.9 ]; then
	echo "Extracting linux headers..."
	tar xzf linux-4.9.tar.gz
fi

if [ ! -d media ]; then
	echo "Extracting media libraries..."
	cat media.tar.gzaa media.tar.gzab | tar xz 
fi


arch=$(uname -p)
if [ "$arch" = "x86_64" ]; then
	if [ ! -d toolchain ]; then
		echo "Extracting toolchain..."
		tar xzvf toolchain.tar.gz
	fi
elif [ "$arch" = "aarch64" ];  then	
	if [ ! -d toolchain_aarch64 ]; then
		echo "Extracting toolchain..."
		cat toolchain_aarch64.tar.gzaa toolchain_aarch64.tar.gzab toolchain_aarch64.tar.gzac toolchain_aarch64.tar.gzad | tar xz
	fi	
fi


rm -rf build && mkdir build
cmake . -DCMAKE_TOOLCHAIN_FILE=toolchain.cmake -Bbuild
