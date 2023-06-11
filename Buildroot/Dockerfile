FROM ubuntu:22.04
RUN cd &&\
perl -p -i.bak -e 's%(deb(?:-src|)\s+)https?://(?!archive\.canonical\.com|security\.ubuntu\.com)[^\s]+%$1http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%' /etc/apt/sources.list &&\
apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:apt-fast/stable && \
 apt-get update && \
apt-get install -y apt-fast
RUN apt-fast install git wget make libncurses-dev binutils build-essential diffutils patch gzip bzip2 bc findutils cpio file rsync unzip -y &&\
rm -rf /var/lib/apt/lists/*
RUN cd &&\
wget https://buildroot.org/downloads/buildroot-2023.02.1.tar.gz
RUN cd &&\tar zxvf buildroot-2023.02.1.tar.gz &&\
rm buildroot-2023.02.1.tar.gz -rf