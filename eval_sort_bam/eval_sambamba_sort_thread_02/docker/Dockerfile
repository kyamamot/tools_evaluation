FROM python:2.7.14
# debian 8.9

RUN echo "deb http://deb.debian.org/debian stretch main" > /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian stretch-updates main" >> /etc/apt/sources.list && \
    echo "deb http://security.debian.org stretch/updates main" >> /etc/apt/sources.list && \
    apt-get -y update && \
    apt-get install -y zlib1g-dev libbz2-dev liblzma-dev && \
    \
    mkdir -p /tools && \
    \
    cd /tools && \
    echo "build sambamba-0.6.8" && \
    wget https://github.com/biod/sambamba/releases/download/v0.6.8/sambamba-0.6.8-linux-static.gz && \
    gunzip sambamba-0.6.8-linux-static.gz && \
    chmod 755 sambamba-0.6.8-linux-static && \
    cp -p sambamba-0.6.8-linux-static /usr/local/bin/sambamba && \
    \
    cd /tools && \
    echo "build samtools-1.9" && \
    wget -nc https://sourceforge.net/projects/samtools/files/samtools/1.9/samtools-1.9.tar.bz2 && \
    tar xjvf samtools-1.9.tar.bz2 && \
    rm -f samtools-1.9.tar.bz2 && \
    cd samtools-1.9 && \
    make && \
    make install && \
    \ 
    echo "export LD_LIBRARY_PATH=/usr/local/lib" >> /root/.bashrc

CMD ["/bin/bash"]
