# 
# bridgewell dockerfile template
#

# Pull base image.
FROM ubuntu:14.04
MAINTAINER Wush Wu

USER root

# modify apt mirror site to tw server
RUN \
    sed -i 's/http:\/\/tw.archive.ubuntu.com\/ubuntu\//http:\/\/ubuntu.cs.nctu.edu.tw\/ubuntu\//g' /etc/apt/sources.list && \
    sed -i 's/http:\/\/us.archive.ubuntu.com\/ubuntu\//http:\/\/ubuntu.cs.nctu.edu.tw\/ubuntu\//g' /etc/apt/sources.list && \
    sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//http:\/\/ubuntu.cs.nctu.edu.tw\/ubuntu\//g' /etc/apt/sources.list && \
    sed 's/main$/main universe/' -i /etc/apt/sources.list

RUN echo "deb http://cran.csie.ntu.edu.tw/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list

# install common tools 
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
RUN apt-get update && apt-get install -y software-properties-common python-software-properties curl r-base libcurl4-openssl-dev libxml2-dev espeak

# install required packages
RUN Rscript -e "install.packages('DSC2014Tutorial', repo = c('http://taiwanrusergroup.github.io/R', 'http://cran.csie.ntu.edu.tw'), type = 'source')"
