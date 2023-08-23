FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade --assume-yes
RUN apt-get --assume-yes install curl gpg wget bash
RUN curl -s -o start.sh https://raw.githubusercontent.com/BeastGamer81/klovitegg/main/install.sh
RUN bash start.sh
