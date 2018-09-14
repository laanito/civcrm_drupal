FROM ubuntu:latest
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y --fix-missing install ansible python-pip openssh-server rsync
RUN pip install -U boto boto3
RUN export AWS_ACCESS_KEY_ID=''
RUN export AWS_SECRET_ACCESS_KEY=''

