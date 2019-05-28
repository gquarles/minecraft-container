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

ENV MAXRAM 2G
ENV MINRAM 1G
ENV MOTD "QHost Containerized Server"
ENV PVP "true"
ENV SPAWN-MONSTERS "true"
ENV MAXPLAYERS "40"

RUN java -Xmx1G -Xms1G -jar server.jar nogui
RUN sed -i 's/false/true/g' eula.txt
RUN sed -i 's/A Minecraft Server/QHost Containerized Server/g' server.properties

RUN touch setup.sh
RUN echo "echo $MAXPLAYERS" > setup.sh

#CMD cp /tmp/* /server/ -rf && cd /server && screen -S server -m java -Xmx${MAXRAM} -Xms${MINRAM} -jar server.jar nogui
