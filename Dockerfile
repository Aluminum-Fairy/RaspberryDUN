FROM ubuntu:22.04
RUN cd &&\
perl -p -i.bak -e 's%(deb(?:-src|)\s+)https?://(?!archive\.canonical\.com|security\.ubuntu\.com)[^\s]+%$1http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%' /etc/apt/sources.list &&\
apt-get update && apt-get install -y software-properties-common && \
rm -rf /var/lib/apt/lists/*
RUN add-apt-repository ppa:apt-fast/stable 
RUN apt-get update && \
apt-get install -y apt-fast && \
apt-fast install git bc bison flex libssl-dev make libc6-dev libncurses5-dev crossbuild-essential-armhf -y &&\
rm -rf /var/lib/apt/lists/*
RUN git clone --depth=1 --single-branch https://github.com/raspberrypi/tools ~/tools
RUN git clone --depth=1 --single-branch -b rpi-6.1.y https://github.com/raspberrypi/linux ~/linux
RUN git clone --depth=1 --single-branch -b aufs6.1 https://github.com/sfjro/aufs-standalone ~/linux/aufs
RUN cd &&\
echo PATH=\$PATH:~/tools/arm-bcm2708/arm-linux-gnueabihf/bin >> ~/.bashrc && \
. ~/.bashrc &&\
cd linux &&\
KERNEL=kernel7 &&\
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig
RUN cd ~/linux &&\
patch -p1 < ~/linux/aufs/aufs6-kbuild.patch &&\
patch -p1 < ~/linux/aufs/aufs6-base.patch &&\
patch -p1 < ~/linux/aufs/aufs6-mmap.patch &&\
cd aufs &&\
cp -rp fs/ ../ &&\
cp -rp Documentation/ ../ &&\
cp -rp include/uapi/linux/aufs_type.h ../include/uapi/linux/ &&\
cd .. &&\
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig 
RUN cd ~/linux && \
echo "make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig menuconfig" >> generateConfig.sh &&\
chmod +x generateConfig.sh &&\
echo "make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs -j6" >> runBuild.sh &&\
chmod +x runBuild.sh &&\
echo "git pull origin rpi-6.1.y && cd aufs && git pull origin aufs6.1" >> getUpdate.sh &&\
chmod +x getUpdate.sh