FROM ubuntu:18.04
RUN apt-get update
RUN apt-get -y install ansible python-pip
RUN pip install -U boto boto3
RUN export AWS_ACCESS_KEY_ID='AKIAJAHKOBFHINZTBSSQ'
RUN export AWS_SECRET_ACCESS_KEY='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'

