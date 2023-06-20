FROM ubuntu:22.04

RUN cd &&\
perl -p -i.bak -e 's%(deb(?:-src|)\s+)https?://(?!archive\.canonical\.com|security\.ubuntu\.com)[^\s]+%$1http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%' /etc/apt/sources.list &&\
apt update && \
apt upgrade -y &&\
apt install git wget make libncurses-dev binutils build-essential diffutils patch gzip bzip2 bc findutils cpio file rsync unzip vim -y
RUN cd &&\
wget https://buildroot.org/downloads/buildroot-2019.11.tar.gz &&\
tar zxvf buildroot-2019.08.tar.gz &&\
rm buildroot-2019.11.tar.gz -rf &&\
#sed -i -e 's/size = 32M/size = 64M/g' /root/buildroot-2019.11.tar.gz/board/raspberrypizero2w/genimage-raspberrypizero2w.cfg &&\
#sed -i -e 's/gpu_mem_256=100/gpu_mem_256=16/g' /root/buildroot-2019.11.tar.gz/board/raspberrypizero2w/config_zero2w.txt &&\
#sed -i -e 's/gpu_mem_512=100/gpu_mem_512=16/g' /root/buildroot-2019.11.tar.gz/board/raspberrypizero2w/config_zero2w.txt &&\
#sed -i -e 's/gpu_mem_1024=100/gpu_mem_1024=16/g' /root/buildroot-2019.11.tar.gz/board/raspberrypizero2w/config_zero2w.txt &&\
rm -rf /var/lib/apt/lists/*
ADD .config /root/buildroot-2019.11.tar.gz/
RUN echo "export FORCE_UNSAFE_CONFIGURE=1" >> ~/.bashrc