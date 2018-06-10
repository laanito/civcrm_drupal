FROM ubuntu:18.04
RUN apt-get update
RUN apt-get -y install ansible python-pip
RUN pip install -U boto
