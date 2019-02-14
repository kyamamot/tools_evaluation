FROM python:2.7.14
# debian 8.9

RUN echo "deb http://deb.debian.org/debian stretch main" > /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian stretch-updates main" >> /etc/apt/sources.list && \
    echo "deb http://security.debian.org stretch/updates main" >> /etc/apt/sources.list && \
    apt-get -y update && \
    apt-get -y install openjdk-8-jre && \
    \
    mkdir -p /tools && \
    \
    cd /tools && \
    echo "build picard-2.18.24" && \
    wget https://github.com/broadinstitute/picard/releases/download/2.18.24/picard.jar

CMD ["/bin/bash"]
