FROM python:2.7.14
# debian 8.9

RUN echo "deb http://deb.debian.org/debian stretch main" > /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian stretch-updates main" >> /etc/apt/sources.list && \
    echo "deb http://security.debian.org stretch/updates main" >> /etc/apt/sources.list && \
    apt-get -y update && \
    \
    mkdir -p /tools && \
    \
    cd /tools && \
    echo "build bwa-0.7.17" && \
    wget http://sourceforge.net/projects/bio-bwa/files/bwa-0.7.17.tar.bz2 && \
    tar xjvf bwa-0.7.17.tar.bz2 && \
    cd bwa-0.7.17 && \
    make

CMD ["/bin/bash"]
