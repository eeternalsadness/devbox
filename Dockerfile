FROM ubuntu:24.04
WORKDIR /root
RUN apt-get update && apt-get install -y git curl xz-utils
