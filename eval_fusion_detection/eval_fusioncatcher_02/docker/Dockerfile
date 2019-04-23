FROM ubuntu:16.04
MAINTAINER Keisuke Yamamoto <ke1suke.yamam0t0.123@gmail.com>

WORKDIR /tools

RUN apt-get update && \
    apt-get install -y \
    bzip2 \
    gcc \
    git \
    make \
    libbz2-dev \
    liblzma-dev \
    libncurses5-dev \
    openjdk-8-jre \
    pigz \
    python \
    python-biopython \
    python-dev \
    python-numpy \
    python-setuptools \
    python-xlrd \
    python-openpyxl \
    pxz \
    unzip \
    wget \
    zip \
    zlib1g-dev \
    xz-utils

RUN wget https://sourceforge.net/projects/bowtie-bio/files/bowtie/1.2.0/bowtie-1.2-linux-legacy-x86_64.zip && \
    unzip bowtie-1.2-linux-legacy-x86_64.zip && \
    rm -f bowtie-1.2-linux-legacy-x86_64.zip

RUN wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.9/bowtie2-2.2.9-linux-x86_64.zip && \
    unzip bowtie2-2.2.9-linux-x86_64.zip && \
    rm -f bowtie2-2.2.9-linux-x86_64.zip

RUN mkdir blat && \
    cd blat && \
    wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/blat/blat && \
    chmod a+x blat

RUN wget https://downloads.sourceforge.net/project/bio-bwa/bwa-0.7.17.tar.bz2 && \
    tar xjf bwa-0.7.17.tar.bz2 && \
    rm -f bwa-0.7.17.tar.bz2 && \
    cd bwa-0.7.17 && \
    make

RUN wget https://sourceforge.net/projects/bbmap/files/BBMap_38.44.tar.gz && \
    tar xzf BBMap_38.44.tar.gz && \
    rm -f BBMap_38.44.tar.gz

RUN mkdir liftOver && \
    cd liftOver && \
    wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/liftOver && \
    chmod a+x liftOver

RUN wget http://www.ebi.ac.uk/~zerbino/velvet/velvet_1.2.10.tgz && \
    tar xzf velvet_1.2.10.tgz && \
    rm -f velvet_1.2.10.tgz && \
    cd velvet_1.2.10 && \
    make

RUN git clone https://github.com/dzerbino/oases.git --recursive -b 0.2.09 && \
    cd oases && \
    make

RUN mkdir faToTwoBit && \
    cd faToTwoBit && \
    wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/faToTwoBit && \
    chmod a+x faToTwoBit

RUN wget https://sourceforge.net/projects/samtools/files/samtools/1.9/samtools-1.9.tar.bz2 && \
    tar xjf samtools-1.9.tar.bz2 && \
    rm -f samtools-1.9.tar.bz2 && \
    cd samtools-1.9 && \
    make

RUN wget https://github.com/ndaniel/seqtk/archive/1.2-r101c.tar.gz && \
    tar xzf 1.2-r101c.tar.gz && \
    rm -f 1.2-r101c.tar.gz && \
    cd seqtk-1.2-r101c && \
    make

RUN wget https://github.com/alexdobin/STAR/archive/2.7.0f.tar.gz && \
    tar xzf 2.7.0f.tar.gz && \
    rm -f 2.7.0f.tar.gz

RUN wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.9.6/sratoolkit.2.9.6-ubuntu64.tar.gz && \
    tar xzf sratoolkit.2.9.6-ubuntu64.tar.gz && \
    rm -f sratoolkit.2.9.6-ubuntu64.tar.gz

RUN wget http://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz && \
    tar xzf lzo-2.10.tar.gz && \
    rm -f lzo-2.10.tar.gz && \
    cd lzo-2.10 && \
    ./configure && \
    make

RUN wget http://www.lzop.org/download/lzop-1.04.tar.gz && \
    tar xzf lzop-1.04.tar.gz && \
    rm -f lzop-1.04.tar.gz && \
    cd lzop-1.04 && \
    export CPPFLAGS=-I/tools/lzo-2.10/include && \
    export LDFLAGS=-L/tools/lzo-2.10/src/.libs && \
    ./configure --prefix=/tools/lzop-1.04 && \
    make && \
    make install

RUN wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.25.tar.xz && \
    tar xf coreutils-8.25.tar.xz && \
    rm -f coreutils-8.25.tar.xz && \
    cd coreutils-8.25 && \
    export FORCE_UNSAFE_CONFIGURE=1 && \
    ./configure --prefix=/tools/coreutils-8.25 && \
    make && \
    make install

RUN wget http://ftp.gnu.org/gnu/parallel/parallel-20170522.tar.bz2 && \
    tar xf parallel-20170522.tar.bz2 && \
    rm -f parallel-20170522.tar.bz2 && \
    cd parallel-20170522 && \
    ./configure --prefix=/tools/parallel-20170522/ && \
    make && \
    make install

RUN wget http://github.com/broadinstitute/picard/releases/download/2.2.2/picard-tools-2.2.2.zip && \
    unzip picard-tools-2.2.2.zip && \
    rm -f picard-tools-2.2.2.zip

RUN git clone https://github.com/ndaniel/fusioncatcher.git && \
    chmod a+x fusioncatcher/bin/fusioncatcher && \
    chmod a+x fusioncatcher/bin/*.py

CMD ["/bin/bash"]
