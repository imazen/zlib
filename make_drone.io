#!/bin/bash

_clean()
{
  git clean -ffde /out > /dev/null
  git reset --hard > /dev/null
}

mkdir out

./thumbs make
./thumbs check
objdump -f build/*.so | grep ^architecture
ldd build/*.so
tar -zcf out/libz-x64.tar.gz --transform 's/.\/build\///;s/.\///' $(./thumbs list)
_clean

sudo apt-get -y update > /dev/null
sudo apt-get -y install gcc-multilib > /dev/null

export tbs_platform=x86
./thumbs make
./thumbs check
objdump -f build/*.so | grep ^architecture
ldd build/*.so
tar -zcf out/libz-x86.tar.gz --transform 's/.\/build\///;s/.\///' $(./thumbs list)
_clean
