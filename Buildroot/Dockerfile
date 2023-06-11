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
RUN cd &&\ 
apt-fast upgrade -y &&\
apt-fast install git wget make libncurses-dev binutils build-essential diffutils patch gzip bzip2 bc findutils cpio file rsync unzip vim -y &&\
wget https://buildroot.org/downloads/buildroot-2023.02.1.tar.gz &&\
tar zxvf buildroot-2023.02.1.tar.gz &&\
rm buildroot-2023.02.1.tar.gz -rf &&\
sed -i -e 's/size = 32M/size = 64M/g' /root/buildroot-2023.02.1/board/raspberrypizero2w/genimage-raspberrypizero2w.cfg &&\
sed -i -e 's/gpu_mem_256=100/gpu_mem_256=16/g' /root/buildroot-2023.02.1/board/raspberrypizero2w/config_zero2w.txt &&\
sed -i -e 's/gpu_mem_512=100/gpu_mem_512=16/g' /root/buildroot-2023.02.1/board/raspberrypizero2w/config_zero2w.txt &&\
sed -i -e 's/gpu_mem_1024=100/gpu_mem_1024=16/g' /root/buildroot-2023.02.1/board/raspberrypizero2w/config_zero2w.txt &&\
rm -rf /var/lib/apt/lists/*
ADD .config /root/buildroot-2023.02.1/