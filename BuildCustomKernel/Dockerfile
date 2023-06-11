FROM ubuntu:22.04
RUN cd &&\
perl -p -i.bak -e 's%(deb(?:-src|)\s+)https?://(?!archive\.canonical\.com|security\.ubuntu\.com)[^\s]+%$1http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%' /etc/apt/sources.list &&\
apt-get update && \
apt-get install gnupg ca-certificates -y && \
apt-key adv --keyserver keyserver.ubuntu.com --recv A2166B8DE8BDC3367D1901C11EE2FF37CA8DA16B &&\
echo "deb https://ppa.launchpadcontent.net/apt-fast/stable/ubuntu jammy main"> /etc/apt/sources.list.d/apt-fast.list &&\
echo "deb-src https://ppa.launchpadcontent.net/apt-fast/stable/ubuntu jammy main ">> /etc/apt/sources.list.d/apt-fast.list &&\
apt-get update && \
apt-get install -y apt-fast
RUN apt-get update && \
apt-fast upgrade -y &&\
apt-fast install git bc bison flex libssl-dev make libc6-dev libncurses5-dev crossbuild-essential-armhf vim -y &&\
rm -rf /var/lib/apt/lists/* &&\
git clone --depth=1 --single-branch https://github.com/raspberrypi/tools ~/tools &&\
git clone --depth=1 --single-branch -b rpi-6.1.y https://github.com/raspberrypi/linux ~/linux &&\
git clone --depth=1 --single-branch -b aufs6.1 https://github.com/sfjro/aufs-standalone ~/linux/aufs
RUN cd &&\
echo PATH=\$PATH:~/tools/arm-bcm2708/arm-linux-gnueabihf/bin >> ~/.bashrc && \
. ~/.bashrc &&\
cd linux &&\
KERNEL=kernel7 &&\
patch -p1 < ~/linux/aufs/aufs6-kbuild.patch &&\
patch -p1 < ~/linux/aufs/aufs6-base.patch &&\
patch -p1 < ~/linux/aufs/aufs6-mmap.patch &&\
cd aufs &&\
cp -rp fs/ ../ &&\
cp -rp Documentation/ ../ &&\
cp -rp include/uapi/linux/aufs_type.h ../include/uapi/linux/ &&\
cd .. &&\
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig 
echo "make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig menuconfig" >> generateConfig.sh &&\
chmod +x generateConfig.sh &&\
echo "make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs -j6" >> runBuild.sh &&\
chmod +x runBuild.sh &&\
echo "git pull origin rpi-6.1.y && cd aufs && git pull origin aufs6.1" >> getUpdate.sh &&\
chmod +x getUpdate.sh