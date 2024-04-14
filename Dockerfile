FROM debian:stable

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \ 
    && apt-get -y upgrade \
    && apt -y --no-install-recommends install curl wget unzip git npm nodejs tar bash lsof software-properties-common ca-certificates openssl figlet zip unzip jq \
    && useradd -ms /bin/bash container

WORKDIR /opt

RUN curl -s "https://get.sdkman.io" | bash && bash "/root/.sdkman/bin/sdkman-init.sh"

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
COPY ./install.sh /install.sh

CMD ["/bin/bash", "/install.sh"]
