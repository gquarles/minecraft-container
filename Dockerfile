FROM openjdk:8u201-jre-alpine

LABEL maintainer "gquarles"

RUN apk add --no-cache -U \
  openssl \
  imagemagick \
  lsof \
  su-exec \
  shadow \
  bash \
  curl iputils wget \
  git \
  jq \
  mysql-client \
  tzdata \
  rsync \
  nano \
  python python-dev py2-pip \
  screen

EXPOSE 25565 25575

WORKDIR /tmp

RUN wget https://launcher.mojang.com/v1/objects/808be3869e2ca6b62378f9f4b33c946621620019/server.jar

RUN java -Xmx1G -Xms1G -jar server.jar nogui
RUN sed -i 's/false/true/g' eula.txt
RUN sed -i 's/A Minecraft Server/QHost Containerized Server/g' server.properties

CMD cp /tmp/* /server/ -rf && cd /server && screen -S server -m java -Xmx2G -Xms1G -jar server.jar nogui
